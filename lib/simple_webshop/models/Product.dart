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

  @override
  String toString() => 'Product model';
}
