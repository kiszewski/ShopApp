class ProductModel {
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  int qtd = 1;

  ProductModel({this.name, this.imageUrl, this.price, this.description});

  void increaseQtd() {
    qtd++;
  }

  void decreaseQtd() {
    if (qtd > 0) {
      qtd--;
    }
  }

  double get totalValue => qtd * price;
}
