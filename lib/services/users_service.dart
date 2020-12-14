import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<UserModel> findUser(String id) async {
    final UserModel user = UserModel();

    final DocumentReference userRef = _firestore.collection('users').doc(id);

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
}
