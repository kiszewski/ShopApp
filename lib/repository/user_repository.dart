import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/models/user_model.dart';
import 'package:shopApp/services/authentication_service.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  final AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);

  UserRepository(this._firestore);

  DocumentReference _getCurrentUserDocRef() {
    User _currentUser = _authenticationService.currentUser;
    return _firestore.collection('users').doc(_currentUser.uid);
  }

  Future<void> addUser(UserModel user) async {
    DocumentReference docRef = _firestore.collection('users').doc(user.id);

    await docRef.set(user.toJson());
  }

  Future<DocumentSnapshot> getCurrentUser() async {
    User _currentUser = _authenticationService.currentUser;

    final DocumentReference userRef =
        _firestore.collection('users').doc(_currentUser.uid);

    return await userRef.get();
  }

  Future toggleFavoriteProduct(ProductModel product) async {
    final DocumentReference docRef = _getCurrentUserDocRef();

    CollectionReference favorites = docRef.collection('favorites');

    await favorites.doc(product.id).get().then((value) {
      value.exists
          ? favorites.doc(product.id).delete()
          : favorites.doc(product.id).set(product.toJson());
    });
  }

  Stream<List<ProductModel>> getFavorites() {
    final DocumentReference docRef = _getCurrentUserDocRef();

    return docRef.collection('favorites').snapshots().map((snapshot) {
      return snapshot.docs
          .map((element) => ProductModel.fromJson(element.id, element.data()))
          .toList();
    });
  }

  Future addInCart(ProductModel product) async {
    final DocumentReference docRef = _getCurrentUserDocRef();

    CollectionReference cart = docRef.collection('cart');

    ItemCartModel itemCart =
        ItemCartModel.fromJson(product.id, product.toJson());
    itemCart.qtd = 1;

    await cart.doc(product.id).set(itemCart.toJson());
  }

  Stream<List<ItemCartModel>> getCart() {
    final DocumentReference docRef = _getCurrentUserDocRef();

    return docRef.collection('cart').snapshots().map((snapshot) {
      return snapshot.docs
          .map((element) => ItemCartModel.fromJson(element.id, element.data()))
          .toList();
    });
  }

  Future removeFromCart(ItemCartModel product) async {
    final DocumentReference docRef = _getCurrentUserDocRef();

    CollectionReference cart = docRef.collection('cart');

    await cart.doc(product.id).delete();
  }

  Future updateQtdItemCart(ItemCartModel product) async {
    User _currentUser = _authenticationService.currentUser;

    DocumentReference docRef =
        _firestore.collection('users').doc(_currentUser.uid);

    CollectionReference cart = docRef.collection('cart');

    cart.doc(product.id).update(product.toJson());
  }

  Stream<List<OrderModel>> getOrders() {
    final DocumentReference docRef = _getCurrentUserDocRef();

    return docRef.collection('orders').snapshots().map((snapshots) {
      return snapshots.docs
          .map((element) => OrderModel.fromJson(element.id, element.data()))
          .toList();
    });
  }

  Future addOrder(List<ItemCartModel> productsInCart) async {
    final DocumentReference docRef = _getCurrentUserDocRef();

    OrderModel order = OrderModel(
      date: Timestamp.now(),
      products: productsInCart,
    );

    await docRef.collection('orders').add(order.toJson());
    productsInCart.forEach((product) {
      removeFromCart(product);
    });
  }
}
