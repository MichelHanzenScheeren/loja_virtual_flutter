import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/drawerPage/myDrawer.dart';
import 'package:lojavirtualflutter/app/pages/homePage/home.dart';

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
      ],
    );
  }
}
