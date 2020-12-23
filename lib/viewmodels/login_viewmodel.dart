import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/services/authentication_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);

  Stream<User> get userStream => _authenticationService.authStateChanges;

  bool get loggedUser => currentUser?.email == null ? false : true;

  User get currentUser => _authenticationService.currentUser;

  Future<String> loginUser(String email, String password) async {
    final resp =
        await _authenticationService.signIn(email: email, password: password);

    return resp.toString();
  }

  Future<String> createUser(String email, String password) async {
    final resp =
        await _authenticationService.signUp(email: email, password: password);

    return resp.toString();
  }

  signInWithGoogle() {
    _authenticationService.signInWithGoogle();
  }

  Future<void> logoutUser() async {
    await _authenticationService.signOut();
    notifyListeners();
  }
}
