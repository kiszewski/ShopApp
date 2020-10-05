import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';

class FavoriteModel extends ChangeNotifier {
  Set<ProductModel> _favoriteProducts = {};

  Set<ProductModel> get favorites => _favoriteProducts;

  void toggleFavorite(ProductModel product) {
    _favoriteProducts.contains(product)
        ? _favoriteProducts.remove(product)
        : _favoriteProducts.add(product);
    notifyListeners();
  }

  bool isFavorite(ProductModel product) {
    return _favoriteProducts.contains(product) ? true : false;
  }
}
