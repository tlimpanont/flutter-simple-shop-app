import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:flutter_app/simple_webshop/reblocs/store.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(AppState state, action) {
    if (action is SetShoppingCart) {
      return state;
    } else if (action is AddProductToCart) {
      return state;
    } else if (action is RemoveProductFromCart) {
      return state;
//      return state.copyWith(
//          shoppingCart: state.shoppingCart.copyWith(
//              products: []
//                ..addAll(state.shoppingCart.products)
//                ..removeWhere((product) => product.id == action.product.id)));
    }
    return state;
  }
}
