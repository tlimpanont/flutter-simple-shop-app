import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/CustomGraphQLProvider.dart';
import 'package:flutter_app/simple_webshop/pages/LoginPage.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:flutter_app/simple_webshop/reblocs/store.dart';
import 'package:flutter_app/simple_webshop/widgets/AppBottomNavigationBar.dart';
import 'package:flutter_app/simple_webshop/widgets/AppDrawer.dart';
import 'package:flutter_app/simple_webshop/widgets/Redirect.dart';
import 'package:rebloc/rebloc.dart';

import 'pages/CartPage.dart';
import 'pages/ProductsCataloguePage.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<NavigatorState> navigationKey = new GlobalKey<NavigatorState>();

class SimpleWebShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: CustomGraphQLProvider(
          child: MaterialApp(
            navigatorKey: navigationKey,
            title: "Simple WebShop App",
            theme: Theme.of(context).copyWith(
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary)),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  print("ROUTE ${settings.name} ");
                  return MaterialPageRoute(builder: (context) => Redirect());
                  break;
                case '/shop':
                  print("ROUTE ${settings.name} ");
                  return MaterialPageRoute(builder: (context) => WebShop());
                  break;
                case '/login':
                  print("ROUTE ${settings.name} ");
                  return MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      body: LoginPage(),
                    );
                  });
              }
            },
          ),
        ));
  }
}

class _WebShopState extends State<WebShop> {
  int _page = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    store.dispatcher(FetchProducts());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("My Simple Webshop"),
        ),
        endDrawer: AppDrawer(),
        body: PageView(
          onPageChanged: _onPageChange,
          controller: _pageController,
          children: [ProductsCataloguePage(), CartPage()],
        ),
        bottomNavigationBar: AppBottomNavigationBar(
            pageController: _pageController, currentPage: _page));
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
