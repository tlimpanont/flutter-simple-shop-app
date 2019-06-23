import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/serializers.dart';

part 'ShoppingCart.g.dart';

abstract class ShoppingCart
    implements Built<ShoppingCart, ShoppingCartBuilder> {
  @nullable
  String get id;
  @nullable
  BuiltList<CartProduct> get cartProducts;

  @nullable
  double get totalPrice => cartProducts.fold(
      0,
      (double curr, CartProduct cartProduct) =>
          curr + cartProduct.product.price);

  static Serializer<ShoppingCart> get serializer => _$shoppingCartSerializer;

  ShoppingCart._();
  factory ShoppingCart([void Function(ShoppingCartBuilder) updates]) =
      _$ShoppingCart;

  static ShoppingCart fromJson(String jsonString) {
    return serializers.deserializeWith(
        ShoppingCart.serializer, jsonDecode(jsonString));
  }

  String toJson() {
    return jsonEncode(serializers.serializeWith(ShoppingCart.serializer, this));
  }
}
