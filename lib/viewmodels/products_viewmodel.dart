import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore;

  ProductsViewModel(this._firestore);

  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((document) => ProductModel(
                document.data()['id'],
                document.data()['name'],
                document.data()['imageUrl'],
                document.data()['price'],
                document.data()['description'],
              ))
          .toList();
    });
  }

  // int get qtdProducts => products;

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
