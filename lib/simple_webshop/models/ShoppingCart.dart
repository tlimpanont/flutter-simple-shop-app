import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingCart extends Model {
  List<Product> products;

  double get totalPrice =>
      products.fold(0, (double curr, Product product) => curr + product.price);

  ShoppingCart({this.products});

  ShoppingCart copyWith({List<Product> products}) {
    ShoppingCart shoppingCart =
        new ShoppingCart(products: products ?? this.products);
    return shoppingCart;
  }
}
