import 'dart:math';
import 'package:shopApp/models/product_model.dart';

class OrderModel {
  final List<ProductModel> _products;
  final Random _random = Random();
  int _id;
  DateTime _date;

  OrderModel(this._products) {
    _id = _random.nextInt(100000);
    _date = DateTime.now();
  }

  List<ProductModel> get products => this._products;

  // double get totalOrder => _products.fold(
  //     0, (previousValue, product) => previousValue + product.totalValue);

  DateTime get date => _date;
}
