import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';

class AppState {
  final ShoppingCart shoppingCart;
  final List<Product> products;
  bool isLoading;

  AppState({this.shoppingCart, this.products, this.isLoading});

  AppState.initialState()
      : shoppingCart = ShoppingCart(products: []),
        products = [],
        isLoading = false;

  AppState copyWith(
      {ShoppingCart shoppingCart, List<Product> products, bool isLoading}) {
    return AppState(
        shoppingCart: shoppingCart ?? this.shoppingCart,
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading);
  }
}
