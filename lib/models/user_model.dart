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

  UserModel();

  UserModel.fromJson(String documentId, Map<String, dynamic> json) {
    this.id = documentId;
    this.name = json['name'];
    this.email = json['email'];
  }

  Map<String, String> toJson() {
    return {
      'name': this.name,
      'email': this.email,
    };
  }
}
