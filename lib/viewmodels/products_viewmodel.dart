import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/repository/product_repository.dart';

class ProductsViewModel {
  ProductRepository _productRepository =
      ProductRepository(FirebaseFirestore.instance);

  Stream<List<ProductModel>> get getProducts =>
      _productRepository.getProducts();

  void _addProduct(ProductModel product) =>
      _productRepository.addProduct(product);

  void _updateProduct(ProductModel product, String name, String imageUrl,
          double price, String description) =>
      _productRepository.updateProduct(
          product, name, imageUrl, price, description);

  void removeProduct(ProductModel product) =>
      _productRepository.removeProduct(product);

  void saveProduct(
      ProductModel product, Map<String, TextEditingController> controllers) {
    if (product == null) {
      final ProductModel newProduct = ProductModel();

      newProduct.name = controllers['name'].text;
      newProduct.imageUrl = controllers['imageUrl'].text;
      newProduct.price = double.tryParse(controllers['price'].text) ?? 0.0;
      newProduct.description = controllers['description'].text;

      _addProduct(newProduct);
    } else {
      _updateProduct(
        product,
        controllers['name'].text,
        controllers['imageUrl'].text,
        double.tryParse(controllers['price'].text) ?? 0.0,
        controllers['description'].text,
      );
    }
  }
}
