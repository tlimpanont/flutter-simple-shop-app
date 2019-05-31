import 'package:bloc/bloc.dart';
import 'package:flutter_app/simple_webshop/models/Product.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCartState {
  ShoppingCartState([List props = const []]);
}

class ShoppingCartLoaded extends ShoppingCartState {
  final List<Product> products;
  double get totalPrice =>
      products.fold(0, (double curr, Product product) => curr + product.price);

  ShoppingCartLoaded([this.products = const []]) : super([products]);
}

@immutable
abstract class ShoppingCartEvent {
  ShoppingCartEvent([List props = const []]);
}

class AddProduct extends ShoppingCartEvent {
  final Product product;

  AddProduct(this.product) : super([product]);
}

class RemoveProduct extends ShoppingCartEvent {
  final Product product;

  RemoveProduct(this.product) : super([product]);
}

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  @override
  ShoppingCartState get initialState => ShoppingCartLoaded(List<Product>());

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
    if (event is AddProduct) {
      yield ShoppingCartLoaded(
          List.from((currentState as ShoppingCartLoaded).products)
            ..add(event.product));
    } else if (event is RemoveProduct) {
      yield ShoppingCartLoaded(
          List.from((currentState as ShoppingCartLoaded).products)
            ..remove(event.product));
    }
  }
}
