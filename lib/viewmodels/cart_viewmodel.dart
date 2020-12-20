import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/repository/user_repository.dart';
import 'package:shopApp/viewmodels/orders_viewmodel.dart';
import 'package:shopApp/models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  StreamSubscription<List<ItemCartModel>> subscription;

  CartViewModel(this.userRepository) {
    subscription = userRepository.getCart().listen((data) {
      productsInCart = data;
      notifyListeners();
      return data;
    });
  }

  List<ItemCartModel> productsInCart;

  // double get totalInCart => _productsInCart.fold(
  //     0, (previousValue, product) => previousValue + product.totalValue);

  int get qtdProducts => productsInCart.length;

  // void order(BuildContext context) {
  //   OrdersViewModel ordersModel =
  //       Provider.of<OrdersViewModel>(context, listen: false);

  //   OrderModel order = OrderModel(this._productsInCart.toList());
  //   ordersModel.addOrder(order);

  //   _productsInCart.clear();
  //   notifyListeners();
  // }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
