import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:flutter_app/simple_webshop/reblocs/store.dart';
import 'package:rebloc/rebloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Redirect extends StatefulWidget {
  final Widget child;

  const Redirect({Key key, this.child}) : super(key: key);
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, bool>(converter: (AppState state) {
      return state.authenticated;
    }, builder: (context, dispatcher, bool authenticated) {
      return Container();
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      var user = (prefs.get('user') != null)
          ? AuthenticatedUser.fromJSON(jsonDecode(prefs.get('user')))
          : null;

      if (user is AuthenticatedUser) {
        store.dispatcher(UserIsAuthenticated(user));

        store.dispatcher(FetchShoppingCartProducts(user.id));

        Navigator.of(context).pushReplacementNamed("/shop");
      } else {
        Navigator.of(context).pushReplacementNamed("/login");
      }
    });
    super.initState();
  }
}
