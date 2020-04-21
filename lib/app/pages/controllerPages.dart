import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/drawer/myDrawer.dart';
import 'package:lojavirtualflutter/app/pages/home/home.dart';
import 'package:lojavirtualflutter/app/pages/products/categories.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: Home(),
          drawer: MyDrawer(pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos", style: Theme.of(context).textTheme.subtitle,),
            centerTitle: true,
          ),
          drawer: MyDrawer(pageController),
          body: Categories(),
        ),
      ],
    );
  }
}
