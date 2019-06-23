import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/serializers.dart';

part 'CartProduct.g.dart';

abstract class CartProduct implements Built<CartProduct, CartProductBuilder> {
  @nullable
  String get id;
  @nullable
  Product get product;

  static Serializer<CartProduct> get serializer => _$cartProductSerializer;

  CartProduct._();
  factory CartProduct([void Function(CartProductBuilder) updates]) =
      _$CartProduct;

  static CartProduct fromJson(String jsonString) {
    return serializers.deserializeWith(
        CartProduct.serializer, jsonDecode(jsonString));
  }

  String toJson() {
    return jsonEncode(serializers.serializeWith(CartProduct.serializer, this));
  }
}
