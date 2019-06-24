import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/serializers.dart';

part 'AppState.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  BuiltList<Product> get products;
  bool get isLoading;
  bool get authenticated;
  @nullable
  AuthenticatedUser get user;

  static Serializer<AppState> get serializer => _$appStateSerializer;

  static AppState initialState() {
    return AppState((appState) => appState
      ..products = ListBuilder()
      ..isLoading = false
      ..authenticated = false
      ..user = null);
  }

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  static AppState fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppState.serializer, jsonDecode(jsonString));
  }

  String toJson() {
    return jsonEncode(serializers.serializeWith(AppState.serializer, this));
  }
}
