import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/services/authentication_service.dart';
import 'package:shopApp/services/users_service.dart';

class FavoriteViewModel extends ChangeNotifier {
  AuthenticationService _authService =
      AuthenticationService(FirebaseAuth.instance);
  UsersService _userService = UsersService(FirebaseFirestore.instance);

  Stream<List<ProductModel>> get favorites {
    String userId = _authService.currentUser.uid;

    return _userService.getFavorites(userId).asBroadcastStream();
  }

  void toggleFavorite(ProductModel product) {
    String userId = _authService.currentUser.uid;
    _userService.toggleFavoriteProduct(userId, product);
    notifyListeners();
  }

  Stream<bool> isFavorite(ProductModel product) {
    String userId = _authService.currentUser.uid;

    return _userService.isFavorite(userId, product).asBroadcastStream();
  }
}
