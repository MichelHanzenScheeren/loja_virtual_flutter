import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualflutter/app/models/orderProduct.dart';

class Order {
  String orderUid;
  String userUid;
  double subtotal;
  double shipping;
  double discount;
  List<OrderProduct> orderProducts;
  int status;
  Timestamp orderTime;

  Order({
    @required this.userUid,
    @required this.subtotal,
    @required this.shipping,
    @required this.discount,
    @required this.orderProducts,
    @required this.status,
  }) {
    orderTime = Timestamp.now();
  }

  Map<String, dynamic> toMap() => {
        "userUid": userUid,
        "subtotal": subtotal,
        "shipping": shipping,
        "discount": discount,
        "orderProducts": orderProducts.map((doc) => doc.toMap()).toList(),
        "status": status,
        "orderTime": orderTime
      };
}
