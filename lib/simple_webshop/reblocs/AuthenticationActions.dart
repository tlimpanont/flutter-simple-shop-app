import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:rebloc/rebloc.dart';

class UserIsAuthenticated extends Action {
  final AuthenticatedUser user;

  UserIsAuthenticated(this.user);
}

class UserIsUnAuthenticated extends Action {}

class SignInUser extends Action {
  final String email;
  final String password;
  SignInUser({this.email, this.password});
}

class SignOutUser extends Action {}
