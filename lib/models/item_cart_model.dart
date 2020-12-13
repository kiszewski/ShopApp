import 'package:shopApp/models/product_model.dart';

class ItemCartModel {
  final ProductModel product;
  int _qtd = 1;

  ItemCartModel(this.product);

  get qtd => _qtd + 0;
  set qtdSetter(int qtd) => _qtd = qtd;
}
