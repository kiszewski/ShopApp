import 'package:flutter/cupertino.dart';
import 'package:shopApp/models/order_model.dart';

class OrdersViewModel extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners();
  }
}
