import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopApp/models/user_model.dart';
import 'package:shopApp/repository/user_repository.dart';

class UserViewModel {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository);

  Future<void> addUser(UserModel user) async =>
      await _userRepository.addUser(user);

  Future<UserModel> getCurrentUser() async {
    DocumentSnapshot userSnapshot = await _userRepository.getCurrentUser();

    return userSnapshot.exists
        ? UserModel.fromJson(userSnapshot.id, userSnapshot.data())
        : UserModel();
  }
}
