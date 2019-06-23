import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uuid/uuid.dart';

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
              allProducts(orderBy: id_DESC) {
                id
                image
                price
                title
              }
            } 
          """, fetchPolicy: FetchPolicy.noCache));
        final List<Product> products =
            List<dynamic>.from(result.data['allProducts']).map((item) {
          return Product.fromJson(jsonEncode(item));
        }).toList();
        context.dispatcher(ProductLoaded(products));
      } else if (context.action is CreateRandomProduct) {
        final String dish = faker.food.dish();
        final product = Product((product) => product
          ..image = 'https://loremflickr.com/800/600/$dish'
          ..title = dish
          ..price = random.nextDouble() * 100);

        await graphQLClient.mutate(MutationOptions(
            document: """
          mutation createProduct(\$image:String!, \$title:String!, \$price:Float!) {
            createProduct(image:\$image, title:\$title, price:\$price) {
              id
              image
              price
              title
            }
          }
        """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "image": product.image,
              "title": product.title,
              "price": product.price,
            }));

        shopScaffoldKey.currentState.removeCurrentSnackBar();
        shopScaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text('${product.title} added to the list')));

        context.dispatcher(FetchProducts());
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
      if (accumulator.action is ProductLoaded) {
        final newState = accumulator.state.rebuild((b) => b
          ..products.clear()
          ..products.addAll((accumulator.action as ProductLoaded).products));
        return Accumulator(accumulator.action, newState);
      }
      return accumulator;
    });
  }
}
