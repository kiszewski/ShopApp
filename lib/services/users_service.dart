import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/models/user_model.dart';

class UsersService {
  final FirebaseFirestore _firestore;

  UsersService(this._firestore);

  Future<String> addUser(UserModel user) async {
    Map<String, dynamic> userMap = {
      'name': user.name,
      'email': user.email,
    };

    DocumentReference document = await _firestore
        .collection('users')
        .doc(user.id)
        .set(userMap)
        .then((value) => null);

    return document?.id;
  }

  Future<UserModel> findUser(String userId) async {
    final UserModel user = UserModel();

    final DocumentReference userRef =
        _firestore.collection('users').doc(userId);

    await userRef.get().then((value) {
      if (value.exists) {
        user.id = value.id;
        user.name = value.data()['name'];
        user.email = value.data()['email'];
      }
    });

    await userRef.collection('cart').get().then((value) {
      user.cart = value.docs.map((element) {
        final ProductModel product =
            ProductModel.fromMap(element.id, element.data());

        final ItemCartModel item = ItemCartModel(product);
        item.qtdSetter = element['qtd'];

        return item;
      }).toList();
    });

    await userRef.collection('favorites').get().then((value) {
      user.favorites = value.docs
          .map((element) => ProductModel.fromMap(element.id, element.data()))
          .toList();
    });

    return user;
  }

  Future toggleFavoriteProduct(String userId, ProductModel product) async {
    DocumentReference docRef = _firestore.collection('users').doc(userId);

    CollectionReference favorites = docRef.collection('favorites');

    await favorites.doc(product.id).get().then((value) {
      value.exists
          ? favorites.doc(product.id).delete()
          : favorites.doc(product.id).set(product.toMap());
    });

    // favorites.get().then((value) {
    //   value.docs.contains(product.id);
    // });

    // await .doc(product.id).set(product.toMap());
  }

  // Future removeFavoriteProduct(String userId, ProductModel product) async {
  //   DocumentReference docRef = _firestore.collection('users').doc(userId);

  //   await docRef.collection('favorites').doc(product.id).delete();
  // }

  Stream<List<ProductModel>> getFavorites(String userId) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);

    return docRef.collection('favorites').get().then((value) {
      return value.docs
          .map((element) => ProductModel.fromMap(element.id, element.data()))
          .toList();
    }).asStream();
  }

  Stream<bool> isFavorite(String userId, ProductModel product) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);

    CollectionReference favorites = docRef.collection('favorites');

    return favorites
        .doc(product.id)
        .get()
        .then((value) => value.exists)
        .asStream();
  }
}
