import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:rebloc/rebloc.dart';

class FetchProducts extends Action {}

class ProductLoaded extends Action {
  final List<Product> products;

  ProductLoaded(this.products);
}

class CreateRandomProduct extends Action {
  final Product product;

  CreateRandomProduct({this.product});
}
