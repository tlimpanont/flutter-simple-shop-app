import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingCart extends Model {
  List<Product> _products = [];

  List<Product> get products => _products;

  double get totalPrice => _products
      .map((product) => product.price)
      .fold(0, (curr, next) => curr + next);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }
}
