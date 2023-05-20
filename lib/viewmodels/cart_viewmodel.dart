import 'package:flutter/material.dart';
import 'package:oonzoo_app/models/product.dart';

class CartViewModel with ChangeNotifier {
  final List<CartProduct> products = [];

  void addProduct(Product product, String size) {
    products.add(CartProduct(product: product, size: size));
    notifyListeners();
  }

  void removeProduct(int index) {
    products.removeAt(index);
    notifyListeners();
  }
}

class CartProduct {
  final Product product;
  final String size;

  CartProduct({
    required this.product,
    required this.size,
  });

  @override
  String toString() => 'CartProduct(product: $product, size: $size)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProduct &&
        other.product == product &&
        other.size == size;
  }

  @override
  int get hashCode => product.hashCode ^ size.hashCode;
}
