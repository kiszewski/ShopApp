import 'dart:math';

class ProductModel {
  // final Random _rnd = Random();
  String id;
  String _name;
  String _imageUrl;
  double _price;
  String _description;
  // int qtd = 1;

  ProductModel(
      this.id, this._name, this._imageUrl, this._price, this._description) {
    // if (this.id == null) {
    //   this.id = _rnd.nextInt(1000000);
    // }
  }

  String get name => this._name;
  String get imageUrl => this._imageUrl;
  double get price => this._price;
  String get description => this._description;
  // double get totalValue => qtd * _price;

  // void increaseQtd() => qtd++;
  // void decreaseQtd() => qtd > 1 ? qtd-- : null;

  // ProductModel copy() {
  //   return new ProductModel(
  //     this.id,
  //     this._name,
  //     this._imageUrl,
  //     this._price,
  //     this._description,
  //   );
  // }

  // update(String name, String imageUrl, double price, String description) {
  //   this._name = name;
  //   this._imageUrl = imageUrl;
  //   this._price = price;
  //   this._description = description;
  // }
}
