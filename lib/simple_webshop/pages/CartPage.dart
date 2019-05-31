import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/blocs/ShoppingCartBloc.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  List<Widget> _getProductsListTile(context) {
    final ShoppingCartBloc _shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);

    return (_shoppingCartBloc.currentState as ShoppingCartLoaded)
        .products
        .map((product) {
      return ListTile(
        onTap: () {},
        title: Text('${product.id}', style: Theme.of(context).textTheme.title),
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
                  SnackBar(content: Text('Product: ${product.id} deleted')));
              _shoppingCartBloc.dispatch(RemoveProduct(product));
            }),
      );
    }).toList(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    final ShoppingCartBloc _shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);

    var listViewChildren = _getProductsListTile(context);
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
                '${currencyFormatter.format((_shoppingCartBloc.currentState as ShoppingCartLoaded).totalPrice)}',
                style: Theme.of(context).textTheme.title,
              )
            ],
          ),
        ),
      ),
    ));

    return ((_shoppingCartBloc.currentState as ShoppingCartLoaded)
            .products
            .isEmpty)
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
                children: listViewChildren,
              )
            ],
          );
  }
}
