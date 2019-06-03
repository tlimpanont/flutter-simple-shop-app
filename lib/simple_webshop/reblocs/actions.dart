import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:rebloc/rebloc.dart';

class AddProductToCart extends Action {
  final Product product;

  AddProductToCart(this.product);
}

class RemoveProductFromCart extends Action {
  final Product product;

  RemoveProductFromCart(this.product);
}
