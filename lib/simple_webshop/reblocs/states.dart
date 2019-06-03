import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';

class AppState {
  final ShoppingCart shoppingCart;

  AppState(this.shoppingCart);

  AppState.initialState() : shoppingCart = ShoppingCart(products: []);

  AppState copyWith({ShoppingCart shoppingCart}) {
    return AppState(shoppingCart ?? this.shoppingCart);
  }
}
