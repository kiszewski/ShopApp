import 'package:shopApp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService {
  final FirebaseFirestore _firestore;

  ProductsService(this._firestore);

  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((document) {
        final ProductModel product = ProductModel();

        product.id = document.id;
        product.name = document.data()['name'];
        product.imageUrl = document.data()['imageUrl'];
        product.price = document.data()['price'];
        product.description = document.data()['description'];

        return product;
      }).toList();
    });
  }

  Future<String> addProduct(ProductModel product) async {
    DocumentReference document = await _firestore.collection('products').add({
      'name': product.name,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'description': product.description,
    });

    return document.id;
  }

  void updateProduct(
    ProductModel product,
    String name,
    String imageUrl,
    double price,
    String description,
  ) async {
    final CollectionReference products = _firestore.collection('products');

    products
        .doc(product.id)
        .update({
          'name': name,
          'imageUrl': imageUrl,
          'price': price,
          'description': description
        })
        .then((value) => print('Product updated'))
        .catchError((error) => print(error));
  }

  void removeProduct(ProductModel product) async {
    final CollectionReference products = _firestore.collection('products');

    products
        .doc(product.id)
        .delete()
        .then((value) => print('Product deleted'))
        .catchError((error) => print(error));
  }
}
