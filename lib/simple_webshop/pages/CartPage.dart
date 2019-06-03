import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:rebloc/rebloc.dart';

class CartPage extends StatelessWidget {
  List<Widget> _getProductsListTile(context, dispatcher, shoppingCart) {
    final List<Product> products = shoppingCart.products;

    return products.map((Product product) {
      return ListTile(
        onTap: () {},
        title:
            Text('${product.title}', style: Theme.of(context).textTheme.title),
        leading: CachedNetworkImage(imageUrl: product.image),
        subtitle: Text(
          '${product.getPriceAsCurrency}',
          style: Theme.of(context).textTheme.subtitle,
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Product: ${product.title} deleted')));
              dispatcher(RemoveProductFromCart(product));
            }),
      );
    }).toList(growable: true);
  }

  List<Widget> _generateChildren(context, dispatcher, shoppingCart) {
    var listViewChildren =
        _getProductsListTile(context, dispatcher, shoppingCart);
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
    return Container(
      child: ViewModelSubscriber<AppState, ShoppingCart>(
        converter: (AppState state) => state.shoppingCart,
        builder: (context, dispatcher, ShoppingCart shoppingCart) {
          return (shoppingCart.products.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 50,
                        foregroundColor: Colors.grey[600],
                        child: Icon(
                          Icons.shopping_cart,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No products in cart',
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                )
              : Stack(
                  children: <Widget>[
                    ListView(
                      children:
                          _generateChildren(context, dispatcher, shoppingCart),
                    )
                  ],
                );
        },
      ),
    );
  }
}
