import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/login_page/sign_up_page.dart';
import 'package:shopApp/pages/wrapper_authentication.dart';
import 'package:shopApp/repository/user_repository.dart';
import 'package:shopApp/viewmodels/login_viewmodel.dart';
import 'package:shopApp/pages/cart_page/cart_page.dart';
import 'package:shopApp/pages/home_page/home_page.dart';
import 'package:shopApp/pages/orders_page/orders_page.dart';
import 'package:shopApp/pages/product_details_page/product_details_page.dart';
import 'package:shopApp/pages/registration_pages/product_form_page.dart';
import 'package:shopApp/pages/registration_pages/products_list_page.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';

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
        Provider<ProductsViewModel>(create: (context) => ProductsViewModel()),
        Provider<UserRepository>(
            create: (context) => UserRepository(FirebaseFirestore.instance)),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(138, 0, 245, 1),
          accentColor: Color.fromRGBO(90, 85, 94, 1),
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
