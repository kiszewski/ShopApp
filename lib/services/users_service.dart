import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopApp/models/user_model.dart';

class UsersService {
  final FirebaseFirestore _firestore;

  UsersService(this._firestore);

  Future<String> addUser(UserModel user) async {
    Map<String, dynamic> userMap = {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'orders': user.orders,
      'favoriteProducts': user.favoriteProducts,
      'productsInCart': user.productsInCart,
    };

    DocumentReference document = await _firestore
        .collection('users')
        .doc(user.id)
        .set(userMap)
        .then((value) => null);

    return document?.id;
  }

  Future<UserModel> findUser(String id) async {
    final users = _firestore.collection('users');

    DocumentSnapshot userFromDB = await users.doc(id).get();

    UserModel user = UserModel();

    if (userFromDB.exists) {
      user.id = userFromDB.data()['id'];
      user.name = userFromDB.data()['name'];
      user.email = userFromDB.data()['email'];
      // user.productsInCart = userFromDB.data()['productsInCart'];
      // user.favoriteProducts = userFromDB.data()['favoriteProducts'];
      // user.orders = userFromDB.data()['orders'];
    }

    return user;
  }
}
