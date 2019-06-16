import 'package:flutter_app/simple_webshop/models/Product.dart';

class ShoppingCart {
  final List<Product> products;
  final String id;

  double get totalPrice =>
      products.fold(0, (double curr, Product product) => curr + product.price);

  ShoppingCart({this.products, this.id});

  ShoppingCart copyWith({List<Product> products, String id}) {
    ShoppingCart shoppingCart = new ShoppingCart(
        products: products ?? this.products, id: id ?? this.id);
    return shoppingCart;
  }
}
