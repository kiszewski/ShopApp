import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/models/user_model.dart';
import 'package:shopApp/services/users_service.dart';

main() async {
  await Firebase.initializeApp();

  final UsersService usersService = UsersService(FirebaseFirestore.instance);
  // final UserModel user = UserModel();
  // user.email = 'leo@email.com';
  // user.name = 'leo';
  // user.id = '123456789987456321';
  // user.cart = [
  // ProductModel(
  //     'Black T-shirt',
  //     'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]',
  //     89,
  //     'Camiseta preta lisa',
  //     id: '888777888777'),
  // ];
  // user.favorites = [
  // ProductModel(
  //     'Black T-shirt',
  //     'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]',
  //     89,
  //     'Camiseta preta lisa',
  //     id: '888777888777'),
  // ];

  test('get user data', () async {
    final UserModel user = await usersService.findUser('1kVDokGgrdY6dSzZwdYO');
    expect(user.name, 'Léo');
  });
}
