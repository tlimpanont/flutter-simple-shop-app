import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/reblocs/actions.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:flutter_app/simple_webshop/widgets/ProductCard.dart';
import 'package:rebloc/rebloc.dart';

var faker = new Faker();

class ProductsCataloguePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, List<Product>>(
      converter: (state) => state.products,
      builder: (BuildContext context, dispatcher, List<Product> products) =>
          RefreshIndicator(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: _crateProductCards(products),
            ),
            onRefresh: () {
              return Future(() => dispatcher(CreateRandomProduct()));
            },
          ),
    );
  }

  List<ProductCard> _crateProductCards(List<Product> products) {
    return List.generate(products.length, (int index) {
      return ProductCard(product: products[index]);
    }).toList();
  }
}
