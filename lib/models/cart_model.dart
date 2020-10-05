import 'package:flutter/cupertino.dart';
import 'package:shopApp/models/product_model.dart';

class CartModel extends ChangeNotifier {
  Set<ProductModel> _productsInCart = {};

  Set<ProductModel> get productsInCart => _productsInCart;

  void addProduct(ProductModel product) {
    _productsInCart.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _productsInCart.remove(product);
    notifyListeners();
  }

  int get qtdProducts => _productsInCart.length;
}
