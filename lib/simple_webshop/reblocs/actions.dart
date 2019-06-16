import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:meta/meta.dart';
import 'package:rebloc/rebloc.dart';

class AddProductToCart extends Action {
  final Product product;

  AddProductToCart(this.product);
}

class PersistAddProductToCart extends Action {
  final String productId;
  final String shoppingCartId;

  PersistAddProductToCart({this.productId, this.shoppingCartId});
}

class PersistRemoveProductFromCart extends Action {
  final String productId;
  final String shoppingCartId;

  PersistRemoveProductFromCart({this.productId, this.shoppingCartId});
}

class RemoveProductFromCart extends Action {
  final Product product;

  RemoveProductFromCart(this.product);
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

class FetchProducts extends Action {}

class ProductLoaded extends Action {
  final List<Product> products;

  ProductLoaded(this.products);
}

class CreateRandomProduct extends Action {
  final Product product;

  CreateRandomProduct({this.product});
}

@immutable
class UserIsAuthenticated extends Action {
  final AuthenticatedUser user;

  UserIsAuthenticated(this.user);
}

class UserIsUnAuthenticated extends Action {}

@immutable
class SignInUser extends Action {
  final String email;
  final String password;
  SignInUser({@required this.email, @required this.password});
}

@immutable
class SignOutUser extends Action {}

@immutable
class CheckIfUserIsAuthenticated extends Action {}
