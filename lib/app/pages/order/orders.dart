import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/controllerPages.dart';
import 'package:lojavirtualflutter/app/pages/user/login/login.dart';
import 'package:lojavirtualflutter/app/widgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class Orders extends StatelessWidget {
  final drawer;
  final cartButton;
  Orders(this.drawer, this.cartButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      floatingActionButton: cartButton,
      appBar: myAppBar(context),
      body: ScopedModelDescendant<User>(
        builder: (context, widget, model) {
          if (!model.isLogged()) {
            return notLogged(context);
          } else if (model.isLoading) {
            return WaitingWidget();
          } else if (model.cartProductsCount() == 0) {
            return ordersEmpty(context);
          } else {
            return Container(color: Colors.red);
          }
        },
      ),
    );
  }

  Widget myAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Meus pedidos",
        style: Theme.of(context).textTheme.subtitle,
      ),
      centerTitle: true,
    );
  }

  Widget notLogged(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.list, size: 120),
          SizedBox(height: 10),
          Text(
            "Faça login para acompanhar seus pedidos...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          MyOkButton("Entrar", Theme.of(context).textTheme.body1, () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Login()),
            );
          }),
        ],
      ),
    );
  }

  Widget ordersEmpty(BuildContext context) {
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
