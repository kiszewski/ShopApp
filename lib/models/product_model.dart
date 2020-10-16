import 'dart:math';

class ProductModel {
  final Random _rnd = Random();
  String _name;
  String _imageUrl;
  double _price;
  String _description;
  int qtd = 1;
  int id;

  ProductModel(this._name, this._imageUrl, this._price, this._description,
      {this.id}) {
    if (this.id == null) {
      this.id = _rnd.nextInt(1000000);
    }
  }

  String get name => this._name;
  String get imageUrl => this._imageUrl;
  double get price => this._price;
  String get description => this._description;
  double get totalValue => qtd * _price;

  void increaseQtd() => qtd++;
  void decreaseQtd() => qtd > 0 ? qtd-- : null;

  ProductModel copy() {
    return new ProductModel(
        this._name, this._imageUrl, this._price, this._description,
        id: this.id);
  }

  set setName(String name) => this._name = name;
  set setPrice(double price) => this._price = price;
  set setDescription(String description) => this._description = description;
  set setImageUrl(String imageUrl) => this._imageUrl = imageUrl;
}
