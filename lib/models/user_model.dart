import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/models/product_model.dart';

class UserModel {
  String id;
  String name;
  String email;
  List<ProductModel> favoriteProducts = [];
  List<ProductModel> productsInCart = [];
  List<OrderModel> orders = [];
}
