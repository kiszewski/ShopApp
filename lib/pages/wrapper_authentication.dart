import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/user_model.dart';
import 'package:shopApp/pages/home_page/home_page.dart';
import 'package:shopApp/pages/login_page/sign_in_page.dart';
import 'package:shopApp/services/authentication_service.dart';
import 'package:shopApp/services/users_service.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/login_viewmodel.dart';

class WrapperAuthentication extends StatefulWidget {
  @override
  _WrapperAuthenticationState createState() => _WrapperAuthenticationState();
}

class _WrapperAuthenticationState extends State<WrapperAuthentication> {
  final UsersService userService = UsersService(FirebaseFirestore.instance);
  final AuthenticationService authService =
      AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // final LoginViewModel loginViewModel =
    //     Provider.of<LoginViewModel>(context, listen: false);

    return StreamBuilder<User>(
      stream: authService.authStateChanges,
      builder: (context, snapshotUser) {
        if (snapshotUser.hasError) {
          return Text(snapshotUser.error);
        }
        switch (snapshotUser.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            if (snapshotUser.hasData && snapshotUser.requireData is User) {
              // User is logged
              return MainHomePageFuture(
                userFromApi: snapshotUser.data,
              );
            } else {
              return SignInPage();
            }
        }
      },
    );
  }
}

class MainHomePageFuture extends StatelessWidget {
  final UsersService userService = UsersService(FirebaseFirestore.instance);
  final User userFromApi;

  MainHomePageFuture({Key key, this.userFromApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: userService.findUser(userFromApi.uid),
      builder: (context, snapshotUserModel) {
        if (snapshotUserModel.data?.id == null) {
          // First login in app
          final UserModel user = UserModel();

          user.email = userFromApi.email;
          user.name = userFromApi.displayName;
          user.id = userFromApi.uid;

          userService.addUser(user);
          return HomePage('MyShop');
        } else {
          return HomePage('My Shop');
        }
      },
    );
    ;
  }
}
