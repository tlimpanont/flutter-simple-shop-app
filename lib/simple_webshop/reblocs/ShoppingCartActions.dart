import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:rebloc/rebloc.dart';

class PersistAddProductToCart extends Action {
  final String shoppingCartId;
  final Product product;

  PersistAddProductToCart({this.shoppingCartId, this.product});
}

class PersistRemoveProductFromCart extends Action {
  final CartProduct cartProduct;
  final String shoppingCartId;

  PersistRemoveProductFromCart({this.cartProduct, this.shoppingCartId});
}

class UpdateCartProducts extends Action {
  final List<CartProduct> cartProducts;

  UpdateCartProducts({this.cartProducts});
}

class FetchShoppingCartProducts extends Action {
  final String userId;

  FetchShoppingCartProducts(this.userId);
}
