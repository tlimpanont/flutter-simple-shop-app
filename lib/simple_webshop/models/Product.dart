import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

final currencyFormatter = new NumberFormat.simpleCurrency(locale: 'nl-NL');

class Product extends Model {
  final String id;
  final String image;
  final String title;
  final double price;

  Product({this.image, this.title, this.price, this.id});

  String get getPriceAsCurrency => currencyFormatter.format(price);

  factory Product.fromJSON(Map<String, dynamic> parsedJSON) {
    return Product(
        price: parsedJSON['price'],
        id: parsedJSON['id'],
        image: parsedJSON['image'],
        title: parsedJSON['title']);
  }

  @override
  String toString() => 'Product model';
}
