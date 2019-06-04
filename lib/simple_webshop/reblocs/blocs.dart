import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(AppState state, action) {
    if (action is AddProductToCart) {
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
          return Product.fromJSON(item);
        }).toList();
        //await Future.delayed(Duration(milliseconds: 1500));
        context.dispatcher(ProductLoaded(products));
      } else if (context.action is CreateRandomProduct) {
        final String dish = faker.food.dish();
        final product = Product(
            image: 'https://loremflickr.com/800/600/$dish',
            title: dish,
            price: random.nextDouble() * 100);

        QueryResult result =
            await graphQLClient.mutate(MutationOptions(document: """
          mutation createProduct(\$image:String!, \$title:String!, \$price:Float!) {
            createProduct(image:\$image, title:\$title, price:\$price) {
              id
              image
              price
              title
            }
          }
        """, variables: {
          "image": product.image,
          "title": product.title,
          "price": product.price,
        }));

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
      if ((accumulator.action is FetchProducts)) {
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

      if (context.action is SingInUser) {
        final credentials = (context.action as SingInUser);
        QueryResult result = await graphQLClient.query(QueryOptions(
            document: """
            mutation signinUser(\$email: String!, \$password:String!) {
              signinUser(email: {email:\$email, password: \$password}) {
                token
                user {
                  id
                  email
                  name
                }
              }
            }
          """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              'email': credentials.email,
              'password': credentials.password,
            }));

        final user = AuthenticatedUser(
            token: result.data['signinUser']['token'],
            id: result.data['signinUser']['user']['id'],
            email: result.data['signinUser']['user']['email'],
            name: result.data['signinUser']['user']['name']);

        prefs.setString(
            'user',
            jsonEncode({
              "token": user.token.toString(),
              "id": user.id.toString(),
              "email": user.email.toString(),
              "name": user.name.toString(),
            }).toString());

        context.dispatcher(UserIsAuthenticated(user));
        context.dispatcher(FetchProducts());
      } else if (context.action is SignOutUser) {
        await prefs.remove('user');
        context.dispatcher(UserIsUnAuthenticated());
      } else if (context.action is CheckIfUserIsAuthenticated) {
        final bool isAuthenticated = (prefs.getString('user') != null);

        if (isAuthenticated) {
          final AuthenticatedUser user =
              AuthenticatedUser.fromJSON(jsonDecode(prefs.getString('user')));
          context.dispatcher(UserIsAuthenticated(user));
        }
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
