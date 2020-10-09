import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/orders_model.dart';
import 'package:shopApp/models/product_model.dart';

class CartModel extends ChangeNotifier {
  Set<ProductModel> _productsInCart = {};

  Set<ProductModel> get productsInCart => _productsInCart;

  double get totalInCart => _productsInCart.fold(
      0, (previousValue, product) => previousValue + product.totalValue);

  int get qtdProducts => _productsInCart.length;

  void addProduct(ProductModel product) {
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

  void order(BuildContext context) {
    OrdersModel ordersModel = Provider.of<OrdersModel>(context);

    ordersModel.addOrder(Order(this._productsInCart.toList()));

    _productsInCart.clear();
    notifyListeners();
  }
}
