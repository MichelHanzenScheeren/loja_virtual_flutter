import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/order.dart';
import 'package:lojavirtualflutter/app/pages/order/mainCard.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class OrderItem extends StatelessWidget {
  final String itemUid;
  OrderItem(this.itemUid);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Colors.transparent,
      elevation: 1,
      child: StreamBuilder<DocumentSnapshot>(
        stream: Database.instance.getOrder(itemUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 50,
              child: WaitingWidget(height: 40, width: 40),
            );
          } else {
            return MainCard(getOrder(snapshot.data));
          }
        },
      ),
    );
  }

  Order getOrder(DocumentSnapshot doc) {
    return Order.fromMap(doc.documentID, doc.data, doc.data["orderProducts"]);
  }
}
