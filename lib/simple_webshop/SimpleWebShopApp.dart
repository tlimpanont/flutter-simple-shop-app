import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

import 'pages/AddProductPage.dart';
import 'pages/CartPage.dart';
import 'pages/ProductsCataloguePage.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
ShoppingCart _shoppingCart = ShoppingCart();

class SimpleWebShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple WebShop App",
      theme: Theme.of(context).copyWith(
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ScopedModel<ShoppingCart>(
              model: _shoppingCart,
              child: WebShop(),
            ),
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/addProduct': (context) => ScopedModel<ShoppingCart>(
            model: _shoppingCart, child: AddProductPage()),
        // When we navigate to the "/second" route, build the SecondScreen Widget
      },
    );
  }
}

class _WebShopState extends State<WebShop> {
  int _page = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ShoppingCart>(
      builder: (context, child, model) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("My Simple Webshop"),
          ),
          bottomNavigationBar: Builder(builder: (BuildContext context) {
            return BottomNavigationBar(
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
                                  '${model.products.length}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                                padding: EdgeInsets.all(1),
                                constraints:
                                    BoxConstraints(minHeight: 16, minWidth: 16),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              top: 0,
                              right: 0)
                        ],
                      )),
                ]);
          }),
          body: PageView(
            onPageChanged: _onPageChange,
            controller: _pageController,
            children: <Widget>[ProductsCataloguePage(), CartPage()],
          )),
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
