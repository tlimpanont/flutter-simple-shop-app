import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/models/ShoppingCart.dart';
import 'package:flutter_app/simple_webshop/reblocs/states.dart';
import 'package:flutter_app/simple_webshop/widgets/ProductCard.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';

var faker = new Faker();

class ProductsCataloguePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, List<Product>>(
      converter: (state) => state.products,
      builder: (BuildContext context, dispatcher, List<Product> viewModel) =>
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: _createProductCards(viewModel),
          ),
    );
  }

  List<ProductCard> _createProductCards(List<Product> products) {
    return List.generate(products.length, (int index) {
      return ProductCard(product: products[index]);
    }).toList();
  }
}
