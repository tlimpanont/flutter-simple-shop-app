import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/addProduct', arguments: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: CachedNetworkImage(
              imageUrl: product.image,
            )),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${product.title}",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "${product.getPriceAsCurrency}",
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
