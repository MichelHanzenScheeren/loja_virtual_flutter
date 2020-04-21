import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtualflutter/app/models/product.dart';

class Database {
  static final Database instance = Database.internal();
  Database.internal();
  factory Database() => instance;

  Future<List> getHomeProducts() async {
    QuerySnapshot query = await Firestore.instance
        .collection("home")
        .orderBy("pos")
        .getDocuments();

    return query.documents;
  }

  Future<List> getProductsCategories() async {
    QuerySnapshot query =
        await Firestore.instance.collection("products").getDocuments();

    return query.documents;
  }

  Future<List<Product>> getProductsList(String category) async {
    QuerySnapshot query = await Firestore.instance
        .collection("products")
        .document(category)
        .collection("items")
        .getDocuments();
    return query.documents.map((product) {
      return Product.fromMap(product.documentID, product);
    }).toList();
  }
}
