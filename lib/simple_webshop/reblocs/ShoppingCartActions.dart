import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
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

class SetShoppingCart extends Action {
  final String shoppingCartId;
  final List<Product> products;

  SetShoppingCart({this.shoppingCartId, this.products});
}

class FetchShoppingCartProducts extends Action {
  final String userId;

  FetchShoppingCartProducts(this.userId);
}
