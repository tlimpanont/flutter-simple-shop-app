import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/CartProduct.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';

@immutable
class CartProductsListView extends StatelessWidget {
  final ShoppingCart shoppingCart;
  final Function onDeleteItem;

  CartProductsListView(
      {@required this.shoppingCart, @required this.onDeleteItem});
  List<Widget> _getProductsListTile(
      BuildContext context, List<CartProduct> cartProducts) {
    return cartProducts.map((CartProduct cartProduct) {
      return ListTile(
        onTap: () {},
        title: Text('${cartProduct.product.title}',
            style: Theme.of(context).textTheme.title),
        leading: CachedNetworkImage(imageUrl: cartProduct.product.image),
        subtitle: Text(
          '${cartProduct.product.getPriceAsCurrency}',
          style: Theme.of(context).textTheme.subtitle,
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(cartProduct);
            }),
      );
    }).toList(growable: true);
  }

  List<Widget> _generateChildren(
      BuildContext context, ShoppingCart shoppingCart) {
    var listViewChildren =
        _getProductsListTile(context, shoppingCart.cartProducts.toList());
    listViewChildren.add(ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Total price: ',
                style: Theme.of(context).textTheme.subhead,
              ),
              Text(
                '${currencyFormatter.format(shoppingCart.totalPrice)}',
                style: Theme.of(context).textTheme.title,
              )
            ],
          ),
        ),
      ),
    ));
    return listViewChildren;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _generateChildren(context, shoppingCart),
    );
  }
}
