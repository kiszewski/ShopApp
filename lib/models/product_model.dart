import 'dart:math';

class ProductModel {
  final Random _rnd = Random();
  final String _name;
  final String _imageUrl;
  final double _price;
  final String _description;
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
}
