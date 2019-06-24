// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'products',
      serializers.serialize(object.products,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Product)])),
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'authenticated',
      serializers.serialize(object.authenticated,
          specifiedType: const FullType(bool)),
    ];
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(AuthenticatedUser)));
    }
    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'products':
          result.products.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Product)])) as BuiltList);
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'authenticated':
          result.authenticated = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(AuthenticatedUser))
              as AuthenticatedUser);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final BuiltList<Product> products;
  @override
  final bool isLoading;
  @override
  final bool authenticated;
  @override
  final AuthenticatedUser user;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.products, this.isLoading, this.authenticated, this.user})
      : super._() {
    if (products == null) {
      throw new BuiltValueNullFieldError('AppState', 'products');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('AppState', 'isLoading');
    }
    if (authenticated == null) {
      throw new BuiltValueNullFieldError('AppState', 'authenticated');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        products == other.products &&
        isLoading == other.isLoading &&
        authenticated == other.authenticated &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, products.hashCode), isLoading.hashCode),
            authenticated.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('products', products)
          ..add('isLoading', isLoading)
          ..add('authenticated', authenticated)
          ..add('user', user))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  ListBuilder<Product> _products;
  ListBuilder<Product> get products =>
      _$this._products ??= new ListBuilder<Product>();
  set products(ListBuilder<Product> products) => _$this._products = products;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _authenticated;
  bool get authenticated => _$this._authenticated;
  set authenticated(bool authenticated) =>
      _$this._authenticated = authenticated;

  AuthenticatedUserBuilder _user;
  AuthenticatedUserBuilder get user =>
      _$this._user ??= new AuthenticatedUserBuilder();
  set user(AuthenticatedUserBuilder user) => _$this._user = user;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _products = _$v.products?.toBuilder();
      _isLoading = _$v.isLoading;
      _authenticated = _$v.authenticated;
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              products: products.build(),
              isLoading: isLoading,
              authenticated: authenticated,
              user: _user?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'products';
        products.build();

        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
