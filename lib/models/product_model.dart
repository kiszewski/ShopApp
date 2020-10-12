class ProductModel {
  final String name;
  final dynamic imageUrl;
  final double price;
  final String description;
  int qtd = 1;

  ProductModel({this.name, this.imageUrl, this.price, this.description});

  double get totalValue => qtd * price;

  void increaseQtd() => qtd++;

  void decreaseQtd() => qtd > 0 ? qtd-- : null;

  ProductModel copy() {
    return new ProductModel(
      name: this.name,
      imageUrl: this.imageUrl,
      price: this.price,
      description: this.description,
    );
  }
}
