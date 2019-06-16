import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartGraphqlBloc extends Bloc<AppState> {
  @override
  Stream<WareContext<AppState>> applyAfterware(
      Stream<WareContext<AppState>> input) {
    input.listen((context) async {
      if (context.action is FetchShoppingCartProducts) {
        final result = await graphQLClient.query(QueryOptions(
            document: """
                    query allUsers(\$userId:ID!) {
                        allUsers(filter:{id:\$userId}) {
                          shoppingCart {
                            id
                            products {
                              id
                              image
                              price
                              title
                            }
                          }
                        }
                      }
                  """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "userId": (context.action as FetchShoppingCartProducts).userId,
            }));

        final List<dynamic> _products =
            result.data['allUsers'][0]['shoppingCart']['products'];

        final products =
            _products.map((product) => Product.fromJSON(product)).toList();

        final shoppingCartId = result.data['allUsers'][0]['shoppingCart']['id'];

        context.dispatcher(SetShoppingCart(
            products: products, shoppingCartId: shoppingCartId));
      } else if (context.action is PersistAddProductToCart) {
        final String productId =
            (context.action as PersistAddProductToCart).productId;
        await graphQLClient.mutate(MutationOptions(
            document: """
                    mutation addToShoppingCartOnProduct(\$productId:ID!, \$shoppingCartId:ID! ) {
                      addToShoppingCartOnProduct(productsProductId: \$productId, shoppingCartsShoppingCartId: \$shoppingCartId) {
                        productsProduct {
                          id
                          image
                        }
                      }
                    }
                  """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "productId": productId,
              "shoppingCartId":
                  (context.action as PersistAddProductToCart).shoppingCartId
            }));

        context.dispatcher(AddProductToCart(context.state.products
            .firstWhere((product) => product.id == productId)));
      } else if (context.action is PersistRemoveProductFromCart) {
        final String productId =
            (context.action as PersistRemoveProductFromCart).productId;
        await graphQLClient.mutate(MutationOptions(
            document: """
                    mutation removeFromShoppingCartOnProduct(\$productId: ID!, \$shoppingCartId: ID!) {
                      removeFromShoppingCartOnProduct(productsProductId: \$productId, shoppingCartsShoppingCartId: \$shoppingCartId) {
                        productsProduct {
                          id
                          image
                        }
                      }
                    }

                  """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              "productId": productId,
              "shoppingCartId": (context.action as PersistRemoveProductFromCart)
                  .shoppingCartId
            }));
        final removingProduct = context.state.products
            .firstWhere((product) => product.id == productId);

        context.dispatcher(RemoveProductFromCart(removingProduct));
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
      return accumulator;
    });
  }
}

class ShoppingCartBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(AppState state, action) {
    if (action is SetShoppingCart) {
      return state.copyWith(
          shoppingCart: state.shoppingCart
              .copyWith(id: action.shoppingCartId, products: action.products));
    } else if (action is AddProductToCart) {
      return state.copyWith(
          shoppingCart: state.shoppingCart.copyWith(
              products: []
                ..addAll(state.shoppingCart.products)
                ..insert(0, action.product)));
    } else if (action is RemoveProductFromCart) {
      return state.copyWith(
          shoppingCart: state.shoppingCart.copyWith(
              products: []
                ..addAll(state.shoppingCart.products)
                ..removeWhere((product) => product.id == action.product.id)));
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
              allProducts(orderBy: id_DESC) {
                id
                image
                price
                title
              }
            } 
          """, fetchPolicy: FetchPolicy.noCache));

        if (result.data != null) {
          final List<Product> products =
              List<dynamic>.from(result.data['allProducts']).map((item) {
            return Product.fromJSON(item);
          }).toList();
          //await Future.delayed(Duration(milliseconds: 1500));
          context.dispatcher(ProductLoaded(products));
        } else {
          shopScaffoldKey.currentState.removeCurrentSnackBar();
          shopScaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('${result.errors[0].message}')));
        }
      } else if (context.action is CreateRandomProduct) {
        final String dish = faker.food.dish();
        final product = Product(
            image: 'https://loremflickr.com/800/600/$dish',
            title: dish,
            price: random.nextDouble() * 100);

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
      if ((accumulator.action is FetchProducts ||
          accumulator.action is SignInUser ||
          accumulator.action is UserIsUnAuthenticated)) {
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

class AuthenticationBloc extends Bloc<AppState> {
  @override
  Stream<WareContext<AppState>> applyAfterware(
      Stream<WareContext<AppState>> input) {
    input.listen((context) async {
      final prefs = await SharedPreferences.getInstance();

      if (context.action is SignInUser) {
        final credentials = (context.action as SignInUser);
        QueryResult result = await graphQLClient.query(QueryOptions(
            document: """
            mutation signinUser(\$email: String!, \$password:String!) {
              signinUser(email: {email:\$email, password: \$password}) {
                token
                user {
                  id
                  email
                  name
                  shoppingCart {
                    id
                  }
                }
              }
            }
          """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              'email': credentials.email,
              'password': credentials.password,
            }));
        if (result.data != null) {
          final user = AuthenticatedUser(
              token: result.data['signinUser']['token'],
              id: result.data['signinUser']['user']['id'],
              email: result.data['signinUser']['user']['email'],
              name: result.data['signinUser']['user']['name'],
              shoppingCartId: result.data['signinUser']['user']['shoppingCart']
                  ['id']);

          final shoppingCart =
              result.data['signinUser']['user']['shoppingCart'];

          if (shoppingCart != null) {
            context.dispatcher(FetchShoppingCartProducts(user.id));
          } else {
            await graphQLClient.query(QueryOptions(
                document: """
            mutation createShoppingCart(\$userId:ID!) {
              createShoppingCart(userId: \$userId) {
                id 
              }
            }
          """,
                fetchPolicy: FetchPolicy.noCache,
                variables: {'userId': user.id}));
            context.dispatcher(FetchShoppingCartProducts(user.id));
          }

          prefs.setString(
              'user',
              jsonEncode({
                "token": user.token.toString(),
                "id": user.id.toString(),
                "email": user.email.toString(),
                "name": user.name.toString(),
                "shoppingCartId": user.shoppingCartId.toString(),
              }).toString());

          context.dispatcher(UserIsAuthenticated(user));
          Future.delayed(
              Duration(milliseconds: 100),
              () => navigationKey.currentState.pushNamedAndRemoveUntil(
                  '/shop', (Route<dynamic> route) => false));
        } else {
          loginPageScaffoldKey.currentState.removeCurrentSnackBar();
          loginPageScaffoldKey.currentState.showSnackBar(SnackBar(
              content:
                  Text('Authentication error ${result.errors[0].message}')));
          context.dispatcher(UserIsUnAuthenticated());
        }
      } else if (context.action is SignOutUser) {
        await prefs.remove('user');
        context.dispatcher(UserIsUnAuthenticated());
        Future.delayed(
            Duration(milliseconds: 100),
            () => navigationKey.currentState.pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false));
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
    return input.map((Accumulator<AppState> accumulator) {
      if (accumulator.action is UserIsAuthenticated) {
        return Accumulator(
            accumulator.action,
            accumulator.state.copyWith(
                user: (accumulator.action as UserIsAuthenticated).user,
                authenticated: true));
      } else if (accumulator.action is UserIsUnAuthenticated) {
        return Accumulator(accumulator.action, AppState.initialState());
      }
      return accumulator;
    });
  }
}
