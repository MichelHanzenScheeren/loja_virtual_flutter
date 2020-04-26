import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualflutter/app/models/cartProduct.dart';
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
      return Product.fromMap(product.documentID, product.data);
    }).toList();
  }

  Future<Product> getProductById(String category, String productId) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection("products")
        .document(category)
        .collection("items")
        .document(productId)
        .get();

    return Product.fromMap(doc.documentID, doc.data);
  }

  Future<String> newCartItem(String userUid, CartProduct cartProduct) async {
    DocumentReference reference = await Firestore.instance
        .collection("users")
        .document(userUid)
        .collection("cart")
        .add(cartProduct.toMap());

    return reference.documentID;
  }

  Future updateCartItemQuantity(String userUid, CartProduct cartProduct) async {
    await Firestore.instance
        .collection("users")
        .document(userUid)
        .collection("cart")
        .document(cartProduct.cartUid)
        .updateData(cartProduct.toMap());
  }

  Future<List<CartProduct>> getCartProducts(String userUid) async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(userUid)
        .collection("cart")
        .getDocuments();

    if (query.documents.length > 0) {
      return query.documents.map((doc) {
        return CartProduct.fromMap(doc.documentID, doc.data);
      }).toList();
    } else {
      return null;
    }
  }

  void removeFromCart(String userUid, String cartUid) {
    Firestore.instance
        .collection("users")
        .document(userUid)
        .collection("cart")
        .document(cartUid)
        .delete();
  }

  Future<Map<String, dynamic>> getCoupom(String text) async {
    DocumentSnapshot doc =
        await Firestore.instance.collection("coupons").document(text).get();
    if (doc.exists) {
      return doc.data;
    } else {
      return null;
    }
  }
}
