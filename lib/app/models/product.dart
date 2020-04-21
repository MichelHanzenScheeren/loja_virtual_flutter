import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String category;
  String title;
  String description;
  double price;
  List images;
  List colors;

  Product.fromMap(DocumentSnapshot data) {
    id = data["id"];
    title = data["title"];
    description = data["description"];
    price = data["price"] + 0.0;
    images = data["images"];
    colors = data["colors"];
  }
}