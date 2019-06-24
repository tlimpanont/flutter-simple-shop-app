import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';
import 'package:flutter_app/simple_webshop/reblocs/ShoppingCartActions.dart';
import 'package:flutter_app/simple_webshop/widgets/CartProducsListView.dart';
import 'package:flutter_app/simple_webshop/widgets/EmptyStateIconLabel.dart';
import 'package:rebloc/rebloc.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ViewModelSubscriber<AppState, ShoppingCart>(
        converter: (AppState state) => state.user.shoppingCart,
        builder: (context, dispatcher, ShoppingCart shoppingCart) {
          return (shoppingCart.cartProducts.isEmpty)
              ? EmptyStateIconLabel(
                  labelText: "No items in cart",
                  iconData: Icons.shopping_cart,
                )
              : CartProductsListView(
                  shoppingCart: shoppingCart,
                  onDeleteItem: (CartProduct cartProduct) => dispatcher(
                      PersistRemoveProductFromCart(
                          cartProduct: cartProduct,
                          shoppingCartId: shoppingCart.id)),
                );
        },
      ),
    );
  }
}
