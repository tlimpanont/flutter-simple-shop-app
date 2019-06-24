import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';
import 'package:flutter_app/simple_webshop/reblocs/AuthenticationBloc.dart';
import 'package:flutter_app/simple_webshop/reblocs/ProductsCatalogueBloc.dart';
import 'package:flutter_app/simple_webshop/reblocs/ShoppingCartBloc.dart';
import 'package:rebloc/rebloc.dart';

final Store<AppState> store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [ProductsCatalogueBloc(), ShoppingCartBloc(), AuthenticationBloc()]);
