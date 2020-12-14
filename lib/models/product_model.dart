import 'dart:math';

class ProductModel {
  // final Random _rnd = Random();
  String id;
  String name;
  String imageUrl;
  double price;
  String description;

  ProductModel();

  ProductModel.fromMap(String id, Map<String, dynamic> productMap) {
    this.id = id;
    this.name = productMap['name'];
    this.description = productMap['description'];
    this.price = productMap['price'] + 0.0;
    this.imageUrl = productMap['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'imageUrl': this.imageUrl,
      'price': this.price,
      'description': this.description,
    };
  }

  // ProductModel(this.name, this.imageUrl, this.price, this.description,
  //     {this.id}) {
  // if (this.id == null) {
  //   this.id = rnd.nextInt(1000000);
  // }
  // }
  // double get totalValue => qtd * price;

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
