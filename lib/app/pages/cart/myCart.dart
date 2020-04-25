import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/controllerPages.dart';
import 'package:lojavirtualflutter/app/pages/user/login/login.dart';
import 'package:lojavirtualflutter/app/widgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: ScopedModelDescendant<User>(
        builder: (context, widget, model) {
          if (!model.isLogged()) {
            return notLoggedWidget();
          } else if (model.isLoading) {
            return WaitingWidget();
          } else if (model.cartProductsCount() == 0) {
            return cartEmpty();
          } else {
            return Container(color: Colors.red);
          }
        },
      ),
    );
  }

  Widget myAppBar() {
    return AppBar(
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
    );
  }

  Widget cartProductsCount() {
    int quantity = User.of(context).cartProductsCount();
    return Text(
      "$quantity ${quantity == 1 ? "Item" : "Itens"}",
      style: Theme.of(context).textTheme.body1,
    );
  }

  Widget notLoggedWidget() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.remove_shopping_cart, size: 120),
          SizedBox(height: 15),
          Text(
            "Faça login para gerenciar seu Carrinho...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 15),
          MyOkButton("Entrar", Theme.of(context).textTheme.body1, () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Login()),
            );
          }),
        ],
      ),
    );
  }

  Widget cartEmpty() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_shopping_cart, size: 120),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Carrinho vazio!",
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
              ),
              SizedBox(width: 10),
              Icon(Icons.sentiment_dissatisfied, size: 28)
            ],
          ),
          SizedBox(height: 5),
          Text(
            "Adicione o primeiro produto:",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 15),
          MyOkButton(
            "Ver produtos",
            Theme.of(context).textTheme.body1,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ControllerPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
