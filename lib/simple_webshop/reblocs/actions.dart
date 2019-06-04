import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:meta/meta.dart';
import 'package:rebloc/rebloc.dart';

class AddProductToCart extends Action {
  final Product product;

  AddProductToCart(this.product);
}

class RemoveProductFromCart extends Action {
  final Product product;

  RemoveProductFromCart(this.product);
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
class SingInUser extends Action {
  final String email;
  final String password;
  SingInUser({@required this.email, @required this.password});
}

@immutable
class SignOutUser extends Action {}

@immutable
class CheckIfUserIsAuthenticated extends Action {}
