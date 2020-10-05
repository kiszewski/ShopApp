import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/models/favorite_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/models/products_model.dart';
import 'package:shopApp/pages/home_page/home_page.dart';
import 'package:shopApp/pages/product_details_page/product_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => FavoriteModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => HomePage('MyShop'),
          'product_details': (context) => ProductDetailsPage(),
        },
      ),
    );
  }
}
