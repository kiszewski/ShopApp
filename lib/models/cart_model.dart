import 'package:flutter/cupertino.dart';
import 'package:shopApp/models/product_model.dart';

class CartModel extends ChangeNotifier {
  Set<ProductModel> _productsInCart = {};

  Set<ProductModel> get productsInCart => _productsInCart;

  void addProduct(ProductModel product) {
    product.qtd = 1;
    _productsInCart.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _productsInCart.remove(product);
    notifyListeners();
  }

  void increaseQtd(ProductModel productModel) {
    productModel.increaseQtd();
    notifyListeners();
  }

  void decreaseQtd(ProductModel productModel) {
    productModel.decreaseQtd();
    notifyListeners();
  }

  int get qtdProducts => _productsInCart.length;
}
