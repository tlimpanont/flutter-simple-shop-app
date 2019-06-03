import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';

class AppState {
  final ShoppingCart shoppingCart;
  final List<Product> products;

  AppState({this.shoppingCart, this.products});

  AppState.initialState()
      : shoppingCart = ShoppingCart(products: []),
        products = [];

  AppState copyWith({ShoppingCart shoppingCart, List<Product> products}) {
    return AppState(
      shoppingCart: shoppingCart ?? this.shoppingCart,
      products: products ?? this.products,
    );
  }
}
