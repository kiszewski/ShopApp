import 'package:flutter/cupertino.dart';
import 'package:shopApp/models/product_model.dart';

class CartModel extends ChangeNotifier {
  List<ProductModel> _productsInCart = [];

  List<ProductModel> get productsInCart => _productsInCart;

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
