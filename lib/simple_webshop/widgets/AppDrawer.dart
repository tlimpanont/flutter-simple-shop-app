import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/models/AuthenticatedUser.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:rebloc/rebloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, AuthenticatedUser>(
        converter: (AppState state) => state.user,
        builder: (context, dispatcher, AuthenticatedUser user) =>
            (user is AuthenticatedUser)
                ? Drawer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DrawerHeader(
                          decoration: BoxDecoration(color: Colors.blue),
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.restaurant,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '${user.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  '${user.email}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        FlatButton(
                          child: Text('Logout'),
                          textColor: Colors.black,
                          onPressed: () {
                            scaffoldKey.currentState.removeCurrentSnackBar();
                            dispatcher(SignOutUser());
                          },
                        )
                      ],
                    ),
                  )
                : Container());
  }
}
