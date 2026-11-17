import 'package:esilv_shop/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  List<Product> build() {
    return [];
  }

  void add(Product product){
    state = [...state, product];
  }

  void remove(Product product){
    state = state.where((elem) => elem.id != product.id).toList();
  }

  String get priceInEuros =>
      "${ (state.fold(0, (prv, actual) => prv + actual.price) / 100)
      .toStringAsFixed(2)}€";
}
