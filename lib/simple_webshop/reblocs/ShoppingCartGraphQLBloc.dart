import 'dart:convert';

import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';

import '../CustomGraphQLProvider.dart';

class ShoppingCartGraphQLBloc extends Bloc<AppState> {
  final updateShoppingCartMutation = """
    mutation updateShoppingCart(\$shoppingCartId:ID!, \$products: [ShoppingCartcartProductsCartProduct!]) {
      updateShoppingCart(id:\$shoppingCartId, cartProducts:\$products) {
        cartProducts(orderBy:id_DESC) {
          id
          product {
            id
            image
            title
            price
          }
        }
      }
    }
  """;
  @override
  Stream<WareContext<AppState>> applyAfterware(
      Stream<WareContext<AppState>> input) {
    input.listen((context) async {
      if (context.action is FetchShoppingCartProducts) {
        final result = await graphQLClient.mutate(MutationOptions(
            document: """
              query allUsers(\$userId: ID!) {
                      allUsers(filter: {id: \$userId}) {
                        shoppingCart {
                          id
                          cartProducts(orderBy:id_DESC) {
                            product {
                              id
                              image
                              price
                              title
                            }
                          }
                        }
                      }
                    }
            """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "userId": (context.action as FetchShoppingCartProducts).userId,
            }));

        final cartProducts = List<dynamic>.from(
                result.data['allUsers'][0]['shoppingCart']['cartProducts'])
            .map((cartProduct) {
          return CartProduct.fromJson(jsonEncode(cartProduct));
        });

        context.dispatcher(
            UpdateCartProducts(cartProducts: cartProducts.toList()));
      } else if (context.action is PersistAddProductToCart) {
        final shoppingCartId =
            (context.action as PersistAddProductToCart).shoppingCartId;
        final productId = (context.action as PersistAddProductToCart).productId;
        var products = context.state.user.shoppingCart.cartProducts
            .map((cartProduct) => {"productId": cartProduct.product.id})
            .toList(growable: true);
        products.add({"productId": productId});

        final result = await graphQLClient.mutate(MutationOptions(
            document: updateShoppingCartMutation,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "products": products,
              "shoppingCartId": shoppingCartId
            }));

        final cartProducts = List<dynamic>.from(
                result.data['updateShoppingCart']['cartProducts'])
            .map((cartProduct) {
          return CartProduct.fromJson(jsonEncode(cartProduct));
        });

        context.dispatcher(
            UpdateCartProducts(cartProducts: cartProducts.toList()));
      }
    });
    return input;
  }

  @override
  Stream<WareContext<AppState>> applyMiddleware(
      Stream<WareContext<AppState>> input) {
    return input;
  }

  @override
  Stream<Accumulator<AppState>> applyReducer(
      Stream<Accumulator<AppState>> input) {
    return input.map((Accumulator<AppState> accumulator) {
      if (accumulator.action is UpdateCartProducts) {
        return Accumulator(
            accumulator.action,
            accumulator.state.rebuild((b) => b
              ..user.shoppingCart.cartProducts.clear()
              ..user.shoppingCart.cartProducts.insertAll(
                  0, (accumulator.action as UpdateCartProducts).cartProducts)));
      }
      return accumulator;
    });
  }
}
