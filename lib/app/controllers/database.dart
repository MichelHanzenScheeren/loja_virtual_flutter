import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtualflutter/app/models/client.dart';
import 'package:lojavirtualflutter/app/models/product.dart';

class Database {
  static final Database instance = Database.internal();
  Database.internal();
  factory Database() => instance;

  Future saveUserData(String uid, Client data) async {
    await Firestore.instance
        .collection("users")
        .document(uid)
        .setData(data.toMap());
  }

  Future<Client> getUserData(String uid) async {
    DocumentSnapshot data =
        await Firestore.instance.collection("users").document(uid).get();
    return Client.fromMap(uid, data.data);
  }

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
