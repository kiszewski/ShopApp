class ItemCartModel {
  String id;
  String name;
  String imageUrl;
  double price;
  int qtd;

  ItemCartModel({this.id, this.name, this.imageUrl, this.price, this.qtd});

  ItemCartModel.fromJson(String id, Map<String, dynamic> json) {
    id = id;
    name = json['name'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    qtd = json['qtd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['qtd'] = this.qtd;
    return data;
  }
}
