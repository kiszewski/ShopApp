import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsViewModel extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ProductModel> _products = [];

  ProductsViewModel() {
    CollectionReference products = _firestore.collection('products');
    products.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _products.add(ProductModel(
          doc['id'],
          doc['name'],
          doc['imageUrl'],
          doc['price'],
          doc['description'],
        ));
      });
    });
  }

  List<ProductModel> get products => [..._products];

  int get qtdProducts => _products.length;

  // void addProduct(ProductModel product) {
  //   _products.add(product);
  //   notifyListeners();
  // }

  // void updateProduct(
  //   ProductModel product,
  //   String name,
  //   String imageUrl,
  //   double price,
  //   String description,
  // ) {
  //   product.update(name, imageUrl, price, description);
  //   notifyListeners();
  // }

  // void removeProduct(ProductModel product) {
  //   _products.remove(product);
  //   notifyListeners();
  // }
}
