import 'package:flutter/cupertino.dart';
import 'package:shopApp/models/order_model.dart';

class OrdersViewModel extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
