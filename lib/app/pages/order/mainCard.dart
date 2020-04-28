import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/order.dart';
import 'package:lojavirtualflutter/app/models/orderProduct.dart';
import 'package:lojavirtualflutter/app/pages/order/descItemOfOrder.dart';
import 'package:lojavirtualflutter/app/pages/order/orderResum.dart';

class MainCard extends StatefulWidget {
  final Order order;
  MainCard(this.order);
  @override
  _MainCardState createState() => _MainCardState(order);
}

class _MainCardState extends State<MainCard> {
  final Order order;
  _MainCardState(this.order);

  final Color iconColor = Color.fromARGB(245, 225, 225, 225);
  final TextStyle title = TextStyle(
    color: Colors.grey[100],
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  final TextStyle subtitle = TextStyle(
    color: Colors.grey[100],
    fontSize: 16,
  );
  Icon outSideCardIcon = Icon(Icons.keyboard_arrow_down,
      color: Color.fromARGB(245, 225, 225, 225));
  Icon insideCardIconOne =
      Icon(Icons.arrow_drop_down, color: Color.fromARGB(245, 225, 225, 225));
  Icon insideCardIconTwo =
      Icon(Icons.arrow_drop_up, color: Color.fromARGB(245, 225, 225, 225));

  String getTotalQuantity(List<OrderProduct> itens) {
    if (itens.length == 0) return "";
    int total = itens.fold(0, (sum, item) {
      return item.quantity + sum;
    });
    return "$total " + (total == 1 ? "item" : "itens");
  }

  void defOutsideCardIcon(bool isExpanded) {
    if (isExpanded) {
      setState(() {
        outSideCardIcon = Icon(Icons.keyboard_arrow_up, color: iconColor);
      });
    } else {
      setState(() {
        outSideCardIcon = Icon(Icons.keyboard_arrow_down, color: iconColor);
      });
    }
  }

  void defInsideCardIconOne(bool isExpanded) {
    if (isExpanded) {
      setState(() {
        insideCardIconOne = Icon(Icons.arrow_drop_up, color: iconColor);
      });
    } else {
      setState(() {
        insideCardIconOne = Icon(Icons.arrow_drop_down, color: iconColor);
      });
    }
  }

  void defInsideCardIconTwo(bool isExpanded) {
    if (isExpanded) {
      setState(() {
        insideCardIconTwo = Icon(Icons.arrow_drop_up, color: iconColor);
      });
    } else {
      setState(() {
        insideCardIconTwo = Icon(Icons.arrow_drop_down, color: iconColor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ExpansionTile(
        onExpansionChanged: defOutsideCardIcon,
        trailing: outSideCardIcon,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            myText("Pedido ${order.orderUid}", title),
            myText("Data: ${order.getTime()}", subtitle),
            myText("${getTotalQuantity(order.orderProducts)}", subtitle),
          ],
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Divider(color: Colors.grey[600]),
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: ExpansionTile(
                    trailing: insideCardIconOne,
                    onExpansionChanged: defInsideCardIconOne,
                    title: myText("Produtos", title),
                    children: order.orderProducts.map((orderProduct) {
                      return DescItemOfOrder(orderProduct, subtitle);
                    }).toList(),
                  ),
                ),
                Divider(color: Colors.grey[600]),
                SizedBox(height: 8),
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    trailing: insideCardIconTwo,
                    onExpansionChanged: defInsideCardIconTwo,
                    title: Text("Resumo do Pedido", style: title),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: OrderResum(
                          order.subtotal,
                          order.discount,
                          order.shipping,
                          subtitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myText(String text, TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(text, style: style, textAlign: TextAlign.left),
        SizedBox(height: 2),
      ],
    );
  }
}
