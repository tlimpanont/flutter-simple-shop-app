// Copyright (c) 2016, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';

part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  Product,
  ShoppingCart,
  CartProduct,
  AuthenticatedUser,
  AppState,
])
final Serializers _serializers = _$_serializers;

final serializers =
    (_serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
