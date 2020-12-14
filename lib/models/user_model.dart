import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/models/product_model.dart';

class UserModel {
  String id;
  String name;
  String email;
  List<ProductModel> favorites = [];
  List<ItemCartModel> cart = [];
  List<OrderModel> orders = [];

  get toMap {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'orders': this.orders,
      'favorites': this.favorites,
      'cart': this.cart,
    };
  }
}