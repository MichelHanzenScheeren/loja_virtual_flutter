import 'package:lojavirtualflutter/app/models/cartProduct.dart';

class OrderProduct {
  String productUid;
  String categoryUid;

  int quantity;
  String color;
  double price;
  String title;

  OrderProduct.fromCartProduct(CartProduct cartProduct) {
    productUid = cartProduct.productUid;
    categoryUid = cartProduct.categoryUid;
    quantity = cartProduct.quantity;
    color = cartProduct.color;
    price = cartProduct.product.price;
    title = cartProduct.product.title;
  }

  Map<String, dynamic> toMap() => {
        "productUid": productUid,
        "categoryUid": categoryUid,
        "quantity": quantity,
        "color": color,
        "price": price,
        "title": title
      };
}
