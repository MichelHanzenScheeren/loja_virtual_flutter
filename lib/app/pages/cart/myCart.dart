import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meu Carrinho",
          style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 27),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            child: cartProductsCount(),
          ),
        ],
      ),
    );
  }

  Widget cartProductsCount() {
    int quantity = User.of(context).cartProductsCount();
    return Text(
      "$quantity  ${quantity == 1 ? "Item" : "Itens"}",
      style: Theme.of(context).textTheme.body1,
    );
  }
}
