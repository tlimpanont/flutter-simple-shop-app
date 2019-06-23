import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/serializers.dart';

part 'AuthenticatedUser.g.dart';

abstract class AuthenticatedUser
    implements Built<AuthenticatedUser, AuthenticatedUserBuilder> {
  @nullable
  String get email;
  @nullable
  String get name;
  @nullable
  String get id;
  @nullable
  ShoppingCart get shoppingCart;

  static Serializer<AuthenticatedUser> get serializer =>
      _$authenticatedUserSerializer;

  AuthenticatedUser._();
  factory AuthenticatedUser([void Function(AuthenticatedUserBuilder) updates]) =
      _$AuthenticatedUser;

  static AuthenticatedUser fromJson(String jsonString) {
    return serializers.deserializeWith(
        AuthenticatedUser.serializer, jsonDecode(jsonString));
  }

  String toJson() {
    return jsonEncode(
        serializers.serializeWith(AuthenticatedUser.serializer, this));
  }
}
