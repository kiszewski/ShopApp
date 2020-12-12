import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/user_model.dart';
import 'package:shopApp/pages/home_page/home_page.dart';
import 'package:shopApp/pages/login_page/sign_in_page.dart';
import 'package:shopApp/services/users_service.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/login_viewmodel.dart';

class WrapperAuthentication extends StatelessWidget {
  final UsersService userService = UsersService(FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return StreamBuilder<User>(
      stream: loginViewModel.userStream,
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
              return FutureBuilder<UserModel>(
                future: userService.findUser(snapshotUser.data.uid),
                builder: (context, snapshotUserModel) {
                  if (snapshotUserModel.data?.email == null) {
                    final UserModel user = UserModel();

                    user.email = snapshotUser.data?.email;
                    user.name = snapshotUser.data?.displayName;
                    user.id = snapshotUser.data?.uid;

                    userService.addUser(user);
                    return HomePage('MyShop');
                  } else {
                    return HomePage('Usuario ja exist');
                  }
                },
              );
            } else {
              return SignInPage();
            }
        }
      },
    );
  }
}
