// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$_serializers = (new Serializers().toBuilder()
      ..add(AppState.serializer)
      ..add(AuthenticatedUser.serializer)
      ..add(CartProduct.serializer)
      ..add(Product.serializer)
      ..add(ShoppingCart.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CartProduct)]),
          () => new ListBuilder<CartProduct>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Product)]),
          () => new ListBuilder<Product>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
