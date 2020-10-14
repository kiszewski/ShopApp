class ProductModel {
  final String _name;
  final String _imageUrl;
  final double _price;
  final String _description;
  int qtd = 1;

  ProductModel(this._name, this._imageUrl, this._price, this._description);

  String get name => this._name;
  dynamic get imageUrl => this._imageUrl;
  double get price => this._price;
  String get description => this._description;

  double get totalValue => qtd * _price;

  void increaseQtd() => qtd++;

  void decreaseQtd() => qtd > 0 ? qtd-- : null;

  ProductModel copy() {
    return new ProductModel(
      this._name,
      this._imageUrl,
      this._price,
      this._description,
    );
  }
}
