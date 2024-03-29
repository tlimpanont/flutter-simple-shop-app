import 'package:baseplate/baseplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';
import 'package:flutter_app/simple_webshop/reblocs/ShoppingCartActions.dart';
import 'package:rebloc/rebloc.dart';

class AddProductPage extends StatelessWidget {
  final Product product;

  const AddProductPage({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, ShoppingCart>(
      converter: (AppState state) => state.user.shoppingCart,
      builder: (BuildContext context, dispatcher, ShoppingCart shoppingCart) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Product: ${product.title}'),
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: bpRow(runSpacing: 8, padding: 8, gutter: 8, children: [
                    bpCol(
                      w1024: 6,
                      w720: 12,
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    bpCol(
                      w1024: 6,
                      w720: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.display1,
                          ),
                          Text(
                            '${product.getPriceAsCurrency}',
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Flex(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  dispatcher(PersistAddProductToCart(
                                      shoppingCartId: shoppingCart.id,
                                      product: product));
                                },
                                child: Text('Add to cart'.toUpperCase()),
                                color: Theme.of(context).accentColor,
                              )
                            ],
                            direction: Axis.vertical,
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
