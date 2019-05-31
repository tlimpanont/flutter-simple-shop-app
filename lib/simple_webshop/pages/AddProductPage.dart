import 'package:baseplate/baseplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/SimpleWebShopApp.dart';
import 'package:flutter_app/simple_webshop/blocs/ShoppingCartBloc.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    final ShoppingCartBloc _shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);

    return BlocBuilder(
      builder: (BuildContext context, ShoppingCartState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Product: ${product.id}'),
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
                                  _shoppingCartBloc
                                      .dispatch(AddProduct(product));
                                  _navigateAndDisplayProduct(context, product);
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
      bloc: _shoppingCartBloc,
    );
  }

  void _navigateAndDisplayProduct(BuildContext context, Product product) async {
    Navigator.pop(context, product);
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text("Product: ${product.id} added")));
  }
}
