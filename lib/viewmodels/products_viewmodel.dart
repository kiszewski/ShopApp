import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';

class ProductsViewModel extends ChangeNotifier {
  List<ProductModel> _products = [];

  ProductsViewModel(this._products);

  List<ProductModel> get products => [..._products];

  int get qtdProducts => _products.length;

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(
    ProductModel product,
    String name,
    String imageUrl,
    double price,
    String description,
  ) {
    product.update(name, imageUrl, price, description);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _products.remove(product);
    notifyListeners();
  }
}
