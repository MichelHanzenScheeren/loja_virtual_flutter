import 'package:lojavirtualflutter/app/models/product.dart';

class Cart {
  String cartUid;
  String productUid;
  String categoryUid;

  int quantity;
  String color;

  Product product;

  Cart.fromMap(String uid, Map data) {
    cartUid = uid;
    productUid = data["productUid"];
    categoryUid = data["categoryUid"];
    quantity = data["quantity"];
    color = data["color"];
  }

  Map<String, dynamic> toMap() => {
        "productUid": productUid,
        "categoryUid": categoryUid,
        "quantity": quantity,
        "color": color,
        "product": product.toResumeMap()
      };
}
