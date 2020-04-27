import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final drawer;
  final cartButton;
  Orders(this.drawer, this.cartButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      floatingActionButton: cartButton,
    );
  }
}
