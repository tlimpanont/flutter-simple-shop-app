import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:flutter_app/simple_webshop/widgets/ProductCard.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';

var faker = new Faker();

class ProductsCataloguePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: _createProductCards(),
    );
  }

  List<ProductCard> _createProductCards() {
    var uuid = new Uuid();
    var random = new Random();

    return List.generate(10, (int index) {
      var title = '${faker.food.dish()}';
      return ProductCard(
          product: new Product(
              id: title,
              image: 'https://loremflickr.com/800/600/$title',
              price: random.nextDouble() * 100,
              title: title));
    }).toList();
  }
}
