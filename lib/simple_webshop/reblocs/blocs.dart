import 'dart:math';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_app/simple_webshop/models/Photo.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uuid/uuid.dart';

class ShoppingCartBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(AppState state, action) {
    if (action is AddProductToCart) {
      return state.copyWith(
          shoppingCart: state.shoppingCart.copyWith(
              products: []
                ..addAll(state.shoppingCart.products)
                ..add(action.product)));
    } else if (action is RemoveProductFromCart) {
      return state.copyWith(
          shoppingCart: state.shoppingCart.copyWith(
              products: []
                ..addAll(state.shoppingCart.products)
                ..remove(action.product)));
    }
    return state;
  }
}

class ProductsCatalogueBloc extends Bloc<AppState> {
  final faker = new Faker();
  final uuid = new Uuid();
  final random = new Random();

  @override
  Stream<WareContext<AppState>> applyAfterware(
      Stream<WareContext<AppState>> input) {
    input.listen((context) async {
      if (context.action is FetchProducts) {
        Response response =
            await Dio().get('https://jsonplaceholder.typicode.com/photos');

        final List<dynamic> mapped = response.data.map((item) {
          return Photo(
            albumId: item['albumId'],
            id: item['id'],
            url: item['url'],
            thumbnailUrl: item['thumbnailUrl'],
            title: item['title'],
          );
        }).toList();

        final photos = List<Photo>.from(mapped);
        final products = List<Product>.from(photos.map((photo) => Product(
            id: uuid.v4(),
            price: this.random.nextDouble() * 100,
            image: photo.url,
            title: faker.food.dish())));
        await Future.delayed(Duration(milliseconds: 1500));
        context.dispatcher(ProductLoaded(products.sublist(0, 200)));
      }
    });

    return input;
  }

  @override
  Stream<WareContext<AppState>> applyMiddleware(
      Stream<WareContext<AppState>> input) {
    // TODO: implement applyMiddleware
    return input;
  }

  @override
  Stream<Accumulator<AppState>> applyReducer(
      Stream<Accumulator<AppState>> input) {
    return input.map((accumulator) {
      if (accumulator.action is FetchProducts) {
        return Accumulator(
            accumulator.action, accumulator.state.copyWith(isLoading: true));
      } else if (accumulator.action is ProductLoaded) {
        return Accumulator(
          accumulator.action,
          accumulator.state.copyWith(
              products: (accumulator.action as ProductLoaded).products,
              isLoading: false),
        );
      }
      return accumulator;
    });
  }
}
