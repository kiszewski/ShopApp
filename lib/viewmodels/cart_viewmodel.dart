import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/viewmodels/orders_viewmodel.dart';
import 'package:shopApp/models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  Set<ProductModel> _productsInCart = {};

  Set<ProductModel> get productsInCart => _productsInCart;

  // double get totalInCart => _productsInCart.fold(
  //     0, (previousValue, product) => previousValue + product.totalValue);

  int get qtdProducts => _productsInCart.length;

  // bool addProduct(ProductModel product) {
  //   bool alreadyInCart =
  //       _productsInCart.any((element) => element.id == product.id);

  //   if (!alreadyInCart) {
  //     _productsInCart.add(product.copy());
  //     notifyListeners();

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  void removeProduct(ProductModel product) {
    _productsInCart.removeWhere((element) => product.id == element.id);
    notifyListeners();
  }

  // void increaseQtd(ProductModel productModel) {
  //   productModel.increaseQtd();
  //   notifyListeners();
  // }

  // void decreaseQtd(ProductModel productModel) {
  //   productModel.decreaseQtd();
  //   notifyListeners();
  // }

  void order(BuildContext context) {
    OrdersViewModel ordersModel =
        Provider.of<OrdersViewModel>(context, listen: false);

    OrderModel order = OrderModel(this._productsInCart.toList());
    ordersModel.addOrder(order);

    _productsInCart.clear();
    notifyListeners();
  }
}
