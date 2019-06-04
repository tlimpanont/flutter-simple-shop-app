import 'dart:math';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/models/Photo.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
        QueryResult result =
            await graphQLClient.query(QueryOptions(document: """
            query {
              allProducts {
                id
                image
                price
                title
              }
            } 
          """));

        final List<Product> products =
            List<dynamic>.from(result.data['allProducts']).map((item) {
          return Product.fromJSON(item);
        }).toList();
        //await Future.delayed(Duration(milliseconds: 1500));
        context.dispatcher(ProductLoaded(products));
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
      if ((accumulator.action is FetchProducts) ||
          (accumulator.action is CreateProduct)) {
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
