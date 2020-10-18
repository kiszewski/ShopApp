import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/login_page/sign_in_page.dart';
import 'package:shopApp/pages/login_page/sign_up_page.dart';
import 'package:shopApp/services/authentication_service.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/viewmodels/favorite_viewmodel.dart';
import 'package:shopApp/viewmodels/orders_viewmodel.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';
import 'package:shopApp/pages/cart_page/cart_page.dart';
import 'package:shopApp/pages/home_page/home_page.dart';
import 'package:shopApp/pages/orders_page/orders_page.dart';
import 'package:shopApp/pages/product_details_page/product_details_page.dart';
import 'package:shopApp/pages/registration_pages/product_form_page.dart';
import 'package:shopApp/pages/registration_pages/products_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (BuildContext ctx) =>
              ctx.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider(create: (context) => ProductsViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => FavoriteViewModel()),
        ChangeNotifierProvider(create: (context) => OrdersViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => WrapperAuthentication(),
          'sign_up': (context) => SignUpPage(),
          'home': (context) => HomePage('MyShop'),
          'cart': (context) => CartPage(),
          'product_details': (context) => ProductDetailsPage(),
          'orders': (context) => OrdersPage(),
          'products_list': (context) => ProductsListPage(),
          'product_form': (context) => ProductFormPage(),
        },
      ),
    );
  }
}

class WrapperAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    User user = context.watch<User>();

    if (user == null) {
      return SignInPage();
    } else {
      return HomePage('MyShop');
    }
  }
}
