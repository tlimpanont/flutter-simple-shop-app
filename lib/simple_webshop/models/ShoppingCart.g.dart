// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingCart.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ShoppingCart> _$shoppingCartSerializer =
    new _$ShoppingCartSerializer();

class _$ShoppingCartSerializer implements StructuredSerializer<ShoppingCart> {
  @override
  final Iterable<Type> types = const [ShoppingCart, _$ShoppingCart];
  @override
  final String wireName = 'ShoppingCart';

  @override
  Iterable serialize(Serializers serializers, ShoppingCart object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.cartProducts != null) {
      result
        ..add('cartProducts')
        ..add(serializers.serialize(object.cartProducts,
            specifiedType: const FullType(
                BuiltList, const [const FullType(CartProduct)])));
    }
    return result;
  }

  @override
  ShoppingCart deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShoppingCartBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cartProducts':
          result.cartProducts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CartProduct)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ShoppingCart extends ShoppingCart {
  @override
  final String id;
  @override
  final BuiltList<CartProduct> cartProducts;

  factory _$ShoppingCart([void Function(ShoppingCartBuilder) updates]) =>
      (new ShoppingCartBuilder()..update(updates)).build();

  _$ShoppingCart._({this.id, this.cartProducts}) : super._();

  @override
  ShoppingCart rebuild(void Function(ShoppingCartBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShoppingCartBuilder toBuilder() => new ShoppingCartBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShoppingCart &&
        id == other.id &&
        cartProducts == other.cartProducts;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), cartProducts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ShoppingCart')
          ..add('id', id)
          ..add('cartProducts', cartProducts))
        .toString();
  }
}

class ShoppingCartBuilder
    implements Builder<ShoppingCart, ShoppingCartBuilder> {
  _$ShoppingCart _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ListBuilder<CartProduct> _cartProducts;
  ListBuilder<CartProduct> get cartProducts =>
      _$this._cartProducts ??= new ListBuilder<CartProduct>();
  set cartProducts(ListBuilder<CartProduct> cartProducts) =>
      _$this._cartProducts = cartProducts;

  ShoppingCartBuilder();

  ShoppingCartBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _cartProducts = _$v.cartProducts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShoppingCart other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ShoppingCart;
  }

  @override
  void update(void Function(ShoppingCartBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ShoppingCart build() {
    _$ShoppingCart _$result;
    try {
      _$result = _$v ??
          new _$ShoppingCart._(id: id, cartProducts: _cartProducts?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cartProducts';
        _cartProducts?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ShoppingCart', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
