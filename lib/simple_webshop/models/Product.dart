import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_app/simple_webshop/serializers.dart';
import 'package:intl/intl.dart';

part 'Product.g.dart';

final currencyFormatter = new NumberFormat.simpleCurrency(locale: 'nl-NL');

abstract class Product implements Built<Product, ProductBuilder> {
  @nullable
  String get id;
  String get image;
  String get title;
  double get price;
  String get getPriceAsCurrency => currencyFormatter.format(price);

  static Serializer<Product> get serializer => _$productSerializer;

  Product._();
  factory Product([void Function(ProductBuilder) updates]) = _$Product;

  static Product fromJson(String jsonString) {
    return serializers.deserializeWith(
        Product.serializer, jsonDecode(jsonString));
  }

  String toJson() {
    return jsonEncode(serializers.serializeWith(Product.serializer, this));
  }
}
