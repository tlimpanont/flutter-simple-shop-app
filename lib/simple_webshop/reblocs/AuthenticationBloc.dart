import 'dart:convert';

import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    cartProducts {
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
            }
          """,
            fetchPolicy: FetchPolicy.noCache,
            variables: {
              'email': credentials.email,
              'password': credentials.password,
            }));
        final user = AuthenticatedUser.fromJson(
            jsonEncode(result.data['signinUser']['user']));

        await prefs.setString(
            'token', jsonEncode(result.data['signinUser']['token']));
        await prefs.setString(
            'user', jsonEncode(result.data['signinUser']['user']));

        context.dispatcher(UserIsAuthenticated(user));
      } else if (context.action is SignOutUser) {}
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
            accumulator.state.rebuild((b) => b
              ..authenticated = true
              ..user = ((accumulator.action as UserIsAuthenticated).user)
                  .toBuilder()));
      }
      return accumulator;
    });
  }
}
