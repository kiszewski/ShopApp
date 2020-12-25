import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/repository/product_repository.dart';

class ProductsViewModel {
  ProductRepository _productRepository =
      ProductRepository(FirebaseFirestore.instance);

  Stream<List<ProductModel>> get getProducts =>
      _productRepository.getProducts();

  Future<String> addProduct(ProductModel product) =>
      _productRepository.addProduct(product);

  void updateProduct(ProductModel product, String name, String imageUrl,
          double price, String description) =>
      _productRepository.updateProduct(
          product, name, imageUrl, price, description);

  void removeProduct(ProductModel product) =>
      _productRepository.removeProduct(product);
}
