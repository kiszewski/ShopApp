import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/repository/user_repository.dart';
import 'package:shopApp/models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  StreamSubscription<List<ItemCartModel>> subscription;
  List<ItemCartModel> productsInCart = [];

  CartViewModel(this.userRepository) {
    subscription = userRepository.getCart().listen((data) {
      productsInCart = data;
      notifyListeners();
      return data;
    });
  }

  Future addInCart(ProductModel product) async {
    await userRepository.addInCart(product);
  }

  Future removeFromCart(ItemCartModel product) async {
    await userRepository.removeFromCart(product);
  }

  double get totalInCart => productsInCart.fold(
      0,
      (previousValue, product) =>
          previousValue + (product.price * product.qtd));

  int get qtdProducts => productsInCart.length ?? 0;

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
