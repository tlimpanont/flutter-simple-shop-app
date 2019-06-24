import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:rebloc/rebloc.dart';

class PersistAddProductToCart extends Action {
  final String shoppingCartId;
  final String productId;

  PersistAddProductToCart({this.shoppingCartId, this.productId});
}

class PersistRemoveProductFromCart extends Action {
  final String cartProductId;
  final String shoppingCartId;

  PersistRemoveProductFromCart({this.cartProductId, this.shoppingCartId});
}

class UpdateCartProducts extends Action {
  final List<CartProduct> cartProducts;

  UpdateCartProducts({this.cartProducts});
}

class FetchShoppingCartProducts extends Action {
  final String userId;

  FetchShoppingCartProducts(this.userId);
}
