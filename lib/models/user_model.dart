import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/models/product_model.dart';

class UserModel {
  final User user;
  List<ProductModel> favoriteProducts;
  List<ProductModel> productsInCart;
  List<OrderModel> orders;

  UserModel(this.user);

  String get name => user.displayName;
}
