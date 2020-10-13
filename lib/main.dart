import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
          '/': (context) => HomePage('MyShop'),
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
