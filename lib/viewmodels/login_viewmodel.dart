import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/services/authentication_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);

  User _user;

  String get userEmail => _user?.email;
  bool get loggedUser => _user != null;

  Future<String> loginUser(String email, String password) async {
    final resp =
        await _authenticationService.signIn(email: email, password: password);

    if (resp is bool && resp == true) {
      _user = _authenticationService.currentUser;
      notifyListeners();
      return '';
    } else if (resp is Exception) {
      return resp.toString();
    }
  }

  Future<String> createUser(String email, String password) async {
    final resp =
        await _authenticationService.signUp(email: email, password: password);

    if (resp is bool && resp == true) {
      _user = _authenticationService.currentUser;
      notifyListeners();
      return '';
    } else if (resp is Exception) {
      return resp.toString();
    }
  }

  Future<String> logoutUser() async {
    await _authenticationService.signOut();
    _user = null;
    notifyListeners();
  }
}
