import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/reblocs/ShoppingCartActions.dart';
import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';

class ShoppingCartBloc extends Bloc<AppState> {
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
                          id
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
        final product = (context.action as PersistAddProductToCart).product;
        final List<String> productIds = context
            .state.user.shoppingCart.cartProducts
            .map((cartProduct) => cartProduct.product.id)
            .toList(growable: true)
              ..add(product.id);

        final result = await graphQLClient.mutate(MutationOptions(
            document: """
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
              """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "products": productIds
                  .map((productId) => {"productId": productId})
                  .toList(),
              "shoppingCartId": shoppingCartId
            }));

        final cartProducts = List<dynamic>.from(
                result.data['updateShoppingCart']['cartProducts'])
            .map((cartProduct) {
          return CartProduct.fromJson(jsonEncode(cartProduct));
        });

        navigationKey.currentState.pop();
        shopScaffoldKey.currentState.removeCurrentSnackBar();
        shopScaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text("Product: ${product.title} added")));

        context.dispatcher(
            UpdateCartProducts(cartProducts: cartProducts.toList()));
      } else if (context.action is PersistRemoveProductFromCart) {
        final shoppingCartId =
            (context.action as PersistRemoveProductFromCart).shoppingCartId;
        final cartProduct =
            (context.action as PersistRemoveProductFromCart).cartProduct;

        final cartProductsIds = context.state.user.shoppingCart.cartProducts
            .map((cartProduct) => cartProduct.id)
            .where((_cartProductId) => _cartProductId != cartProduct.id)
            .toList();

        try {
          final result = await graphQLClient.mutate(MutationOptions(
              document: """
                mutation updateShoppingCart(\$shoppingCartId:ID!, \$cartProductsIds: [ID!]) {
                  updateShoppingCart(id:\$shoppingCartId, cartProductsIds:\$cartProductsIds) {
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
              """,
              fetchPolicy: FetchPolicy.noCache,
              variables: {
                "cartProductsIds": cartProductsIds,
                "shoppingCartId": shoppingCartId
              }));
          if (result.errors == null) {
            final cartProducts = List<dynamic>.from(
                    result.data['updateShoppingCart']['cartProducts'])
                .map((cartProduct) {
              return CartProduct.fromJson(jsonEncode(cartProduct));
            });

            shopScaffoldKey.currentState.removeCurrentSnackBar();
            shopScaffoldKey.currentState.showSnackBar(SnackBar(
                content:
                    Text('Product: ${cartProduct.product.title} deleted')));

            context.dispatcher(
                UpdateCartProducts(cartProducts: cartProducts.toList()));
          } else {
            print(result.errors);
          }
        } catch (e) {
          print(e);
        }
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
