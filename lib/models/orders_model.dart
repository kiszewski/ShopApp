import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shopApp/models/product_model.dart';

class OrdersModel extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}

class Order {
  final List<ProductModel> _products;
  final Random _random = Random();
  int _id;
  DateTime _date;

  Order(this._products) {
    _id = _random.nextInt(100000);
    _date = DateTime.now();
  }

  double get totalOrder => _products.fold(
      0, (previousValue, product) => previousValue + product.totalValue);

  DateTime get date => _date;
}
