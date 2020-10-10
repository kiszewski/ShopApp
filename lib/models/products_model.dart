import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';

class ProductsModel extends ChangeNotifier {
  List<ProductModel> _products = [
    ProductModel(
        name: 'Black T-shirt',
        imageUrl:
            'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]',
        price: 89,
        description: 'Camiseta preta lisa'),
    ProductModel(
        name: 'White T-shirt',
        imageUrl:
            'https://cdn.shoplo.com/9107/products/th2048/abam/3740-1106-1346-14.png',
        price: 89,
        description: 'Camiseta branca lisa'),
    ProductModel(
        name: 'Red T-shirt',
        imageUrl:
            'https://cdn.awsli.com.br/600x450/44/44273/produto/29989858/b28e079baa.jpg',
        price: 89,
        description: 'Camiseta vermelha lisa'),
    ProductModel(
        name: 'Tenis preto',
        imageUrl:
            'https://artwalk.vteximg.com.br/arquivos/ids/218426-1000-1000/Tenis-Nike-Air-Max-97-Masculino-Multicolor.jpg?v=637091629305300000',
        price: 89,
        description: 'Tenis Nike preto'),
  ];

  List<ProductModel> get products => _products;

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _products.remove(product);
    notifyListeners();
  }

  int get qtdProducts => _products.length;
}
