class ProductModel {
  String id;
  String name;
  String imageUrl;
  double price;
  String description;

  ProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.description,
  });

  ProductModel.fromJson(String id, Map<String, dynamic> productMap) {
    this.id = id;
    this.name = productMap['name'];
    this.description = productMap['description'];
    this.price = productMap['price'] + 0.0;
    this.imageUrl = productMap['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'imageUrl': this.imageUrl,
      'price': this.price,
      'description': this.description,
    };
  }
}
