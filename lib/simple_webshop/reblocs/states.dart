import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ShoppingCart shoppingCart;
  final List<Product> products;
  final bool isLoading;
  final bool authenticated;
  final AuthenticatedUser user;

  AppState(
      {this.shoppingCart,
      this.products,
      this.isLoading,
      this.user,
      this.authenticated});

  AppState.initialState()
      : shoppingCart = ShoppingCart(products: []),
        products = [],
        isLoading = false,
        authenticated = false,
        user = null;

  AppState copyWith(
      {ShoppingCart shoppingCart,
      List<Product> products,
      bool isLoading,
      bool authenticated,
      AuthenticatedUser user}) {
    return AppState(
      shoppingCart: shoppingCart ?? this.shoppingCart,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      authenticated: authenticated ?? this.authenticated,
      user: user ?? this.user,
    );
  }
}
