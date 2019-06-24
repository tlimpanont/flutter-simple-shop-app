import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';
import 'package:rebloc/rebloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final PageController pageController;
  final int currentPage;

  const AppBottomNavigationBar({Key key, this.pageController, this.currentPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, int>(
      converter: (AppState state) =>
          state.user.shoppingCart.cartProducts.length,
      builder: (context, dispatcher, countShoppingCartItems) =>
          BottomNavigationBar(
              currentIndex: currentPage,
              onTap: (int page) async {
                await pageController.animateToPage(page,
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
                                '$countShoppingCartItems',
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
              ]),
    );
  }
}
