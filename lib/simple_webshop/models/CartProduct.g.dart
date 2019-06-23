// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartProduct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CartProduct> _$cartProductSerializer = new _$CartProductSerializer();

class _$CartProductSerializer implements StructuredSerializer<CartProduct> {
  @override
  final Iterable<Type> types = const [CartProduct, _$CartProduct];
  @override
  final String wireName = 'CartProduct';

  @override
  Iterable serialize(Serializers serializers, CartProduct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.product != null) {
      result
        ..add('product')
        ..add(serializers.serialize(object.product,
            specifiedType: const FullType(Product)));
    }
    return result;
  }

  @override
  CartProduct deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CartProductBuilder();

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
        case 'product':
          result.product.replace(serializers.deserialize(value,
              specifiedType: const FullType(Product)) as Product);
          break;
      }
    }

    return result.build();
  }
}

class _$CartProduct extends CartProduct {
  @override
  final String id;
  @override
  final Product product;

  factory _$CartProduct([void Function(CartProductBuilder) updates]) =>
      (new CartProductBuilder()..update(updates)).build();

  _$CartProduct._({this.id, this.product}) : super._();

  @override
  CartProduct rebuild(void Function(CartProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CartProductBuilder toBuilder() => new CartProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CartProduct && id == other.id && product == other.product;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), product.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CartProduct')
          ..add('id', id)
          ..add('product', product))
        .toString();
  }
}

class CartProductBuilder implements Builder<CartProduct, CartProductBuilder> {
  _$CartProduct _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ProductBuilder _product;
  ProductBuilder get product => _$this._product ??= new ProductBuilder();
  set product(ProductBuilder product) => _$this._product = product;

  CartProductBuilder();

  CartProductBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _product = _$v.product?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CartProduct other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CartProduct;
  }

  @override
  void update(void Function(CartProductBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CartProduct build() {
    _$CartProduct _$result;
    try {
      _$result = _$v ?? new _$CartProduct._(id: id, product: _product?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CartProduct', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
