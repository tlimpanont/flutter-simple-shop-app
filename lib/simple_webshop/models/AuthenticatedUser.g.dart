// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthenticatedUser.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AuthenticatedUser> _$authenticatedUserSerializer =
    new _$AuthenticatedUserSerializer();

class _$AuthenticatedUserSerializer
    implements StructuredSerializer<AuthenticatedUser> {
  @override
  final Iterable<Type> types = const [AuthenticatedUser, _$AuthenticatedUser];
  @override
  final String wireName = 'AuthenticatedUser';

  @override
  Iterable serialize(Serializers serializers, AuthenticatedUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.shoppingCart != null) {
      result
        ..add('shoppingCart')
        ..add(serializers.serialize(object.shoppingCart,
            specifiedType: const FullType(ShoppingCart)));
    }
    return result;
  }

  @override
  AuthenticatedUser deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthenticatedUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shoppingCart':
          result.shoppingCart.replace(serializers.deserialize(value,
              specifiedType: const FullType(ShoppingCart)) as ShoppingCart);
          break;
      }
    }

    return result.build();
  }
}

class _$AuthenticatedUser extends AuthenticatedUser {
  @override
  final String email;
  @override
  final String name;
  @override
  final String id;
  @override
  final ShoppingCart shoppingCart;

  factory _$AuthenticatedUser(
          [void Function(AuthenticatedUserBuilder) updates]) =>
      (new AuthenticatedUserBuilder()..update(updates)).build();

  _$AuthenticatedUser._({this.email, this.name, this.id, this.shoppingCart})
      : super._() {
    if (email == null) {
      throw new BuiltValueNullFieldError('AuthenticatedUser', 'email');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('AuthenticatedUser', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('AuthenticatedUser', 'id');
    }
  }

  @override
  AuthenticatedUser rebuild(void Function(AuthenticatedUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthenticatedUserBuilder toBuilder() =>
      new AuthenticatedUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthenticatedUser &&
        email == other.email &&
        name == other.name &&
        id == other.id &&
        shoppingCart == other.shoppingCart;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, email.hashCode), name.hashCode), id.hashCode),
        shoppingCart.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthenticatedUser')
          ..add('email', email)
          ..add('name', name)
          ..add('id', id)
          ..add('shoppingCart', shoppingCart))
        .toString();
  }
}

class AuthenticatedUserBuilder
    implements Builder<AuthenticatedUser, AuthenticatedUserBuilder> {
  _$AuthenticatedUser _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ShoppingCartBuilder _shoppingCart;
  ShoppingCartBuilder get shoppingCart =>
      _$this._shoppingCart ??= new ShoppingCartBuilder();
  set shoppingCart(ShoppingCartBuilder shoppingCart) =>
      _$this._shoppingCart = shoppingCart;

  AuthenticatedUserBuilder();

  AuthenticatedUserBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _name = _$v.name;
      _id = _$v.id;
      _shoppingCart = _$v.shoppingCart?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthenticatedUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AuthenticatedUser;
  }

  @override
  void update(void Function(AuthenticatedUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthenticatedUser build() {
    _$AuthenticatedUser _$result;
    try {
      _$result = _$v ??
          new _$AuthenticatedUser._(
              email: email,
              name: name,
              id: id,
              shoppingCart: _shoppingCart?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'shoppingCart';
        _shoppingCart?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AuthenticatedUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
