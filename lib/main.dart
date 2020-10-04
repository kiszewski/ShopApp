import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/home_page/home_page.dart';
import 'package:shopApp/pages/product_details_page/product_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<ProductModel> products = [
    ProductModel(
        'Black T-shirt',
        'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]',
        89,
        'Camiseta preta lisa'),
    ProductModel(
        'White T-shirt',
        'https://cdn.shoplo.com/9107/products/th2048/abam/3740-1106-1346-14.png',
        89,
        'Camiseta branca lisa'),
    ProductModel(
        'Red T-shirt',
        'https://cdn.awsli.com.br/600x450/44/44273/produto/29989858/b28e079baa.jpg',
        89,
        'Camiseta vermelha lisa'),
    ProductModel(
        'Tenis preto',
        'https://artwalk.vteximg.com.br/arquivos/ids/218426-1000-1000/Tenis-Nike-Air-Max-97-Masculino-Multicolor.jpg?v=637091629305300000',
        89,
        'Tenis Nike preto'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => HomePage('MyShop', products),
          'product_details': (context) => ProductDetailsPage(),
        },
      ),
    );
  }
}
