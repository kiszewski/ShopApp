import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopApp/models/item_cart_model.dart';

class OrderModel {
  String id;
  Timestamp date;
  List<ItemCartModel> products;

  OrderModel({this.id, this.date, this.products});

  OrderModel.fromJson(String documentId, Map<String, dynamic> json) {
    id = documentId;
    date = json['date'];
    if (json['products'] != null) {
      products = new List<ItemCartModel>();
      json['products'].forEach((v) {
        products.add(new ItemCartModel.fromJson(v['id'], v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = this.products.map((v) {
        Map<String, dynamic> itemData = v.toJson();
        itemData['id'] = v.id;
        return itemData;
      }).toList();
    }
    return data;
  }
}
