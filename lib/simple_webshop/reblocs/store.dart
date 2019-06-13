import 'package:flutter_app/simple_webshop/reblocs/blocs.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:rebloc/rebloc.dart';

final Store<AppState> store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [ProductsCatalogueBloc(), ShoppingCartBloc(), AuthenticationBloc()]);
