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

class WrapperAuthentication extends StatefulWidget {
  @override
  _WrapperAuthenticationState createState() => _WrapperAuthenticationState();
}

class _WrapperAuthenticationState extends State<WrapperAuthentication> {
  final UsersService userService = UsersService(FirebaseFirestore.instance);
  final AuthenticationService authService =
      AuthenticationService(FirebaseAuth.instance);

  Stream<User> streamToCall;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    streamToCall = authService.authStateChanges;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return StreamBuilder<User>(
      stream: streamToCall,
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

class MainHomePageFuture extends StatefulWidget {
  final User userFromApi;

  MainHomePageFuture({Key key, this.userFromApi}) : super(key: key);

  @override
  _MainHomePageFutureState createState() => _MainHomePageFutureState();
}

class _MainHomePageFutureState extends State<MainHomePageFuture> {
  UsersService userService;
  Future<UserModel> findUser;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    userService = UsersService(FirebaseFirestore.instance);
    findUser = userService.findUser(widget.userFromApi.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: findUser,
      builder: (context, snapshotUserModel) {
        if (snapshotUserModel.connectionState == ConnectionState.done) {
          if (snapshotUserModel.data?.id == null) {
            // First login in app
            final UserModel user = UserModel();

            user.email = widget.userFromApi.email;
            user.name = widget.userFromApi.displayName;
            user.id = widget.userFromApi.uid;

            userService.addUser(user);
          }
          return HomePage('MyShop');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
