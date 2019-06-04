import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/pages/LoginPage.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/blocs.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:rebloc/rebloc.dart';

import 'pages/AddProductPage.dart';
import 'pages/CartPage.dart';
import 'pages/ProductsCataloguePage.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
final Store<AppState> _store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [ProductsCatalogueBloc(), ShoppingCartBloc(), AuthenticationBloc()]);

class SimpleWebShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: _store,
        child: CustomGraphQLProvider(
          child: MaterialApp(
            title: "Simple WebShop App",
            theme: Theme.of(context).copyWith(
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary)),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) {
                return WebShop();
              },
              // When we navigate to the "/" route, build the FirstScreen Widget
              '/addProduct': (context) {
                return AddProductPage();
              },
              // When we navigate to the "/second" route, build the SecondScreen Widget
            },
          ),
        ));
  }
}

class _WebShopState extends State<WebShop> {
  int _page = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, AppState>(
      converter: (AppState state) => state,
      builder: (context, dispatcher, AppState appState) => Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text("My Simple Webshop"),
            ),
            endDrawer: (appState.authenticated)
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
                                  '${appState.user.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  '${appState.user.email}',
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
                            Navigator.pop(context);
                            dispatcher(SignOutUser());
                          },
                        )
                      ],
                    ),
                  )
                : null,
            body: PageView(
              onPageChanged: _onPageChange,
              controller: _pageController,
              children: (appState.isLoading)
                  ? [
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ]
                  : (appState.authenticated)
                      ? [ProductsCataloguePage(), CartPage()]
                      : [
                          LoginPage(onSubmit: ({email, password}) {
                            dispatcher(
                                SingInUser(email: email, password: password));
                          }),
                        ],
            ),
            bottomNavigationBar: (appState.authenticated)
                ? BottomNavigationBar(
                    currentIndex: _page,
                    onTap: (int page) async {
                      setState(() {
                        this._page = page;
                      });

                      await _pageController.animateToPage(page,
                          duration: new Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    items: [
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.photo_library,
                            size: 32,
                          ),
                          title: Text(''),
                        ),
                        BottomNavigationBarItem(
                            title: Text(''),
                            icon: Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  size: 32,
                                ),
                                Positioned(
                                    child: Container(
                                      child: Text(
                                        '${appState.shoppingCart.products.length}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                      padding: EdgeInsets.all(1),
                                      constraints: BoxConstraints(
                                          minHeight: 16, minWidth: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    top: 0,
                                    right: 0)
                              ],
                            )),
                      ])
                : null,
          ),
    );
  }

  void _onPageChange(int value) {
    setState(() {
      _page = value;
    });
  }
}

class WebShop extends StatefulWidget {
  final PageController pageController;

  const WebShop({Key key, this.pageController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebShopState();
}
