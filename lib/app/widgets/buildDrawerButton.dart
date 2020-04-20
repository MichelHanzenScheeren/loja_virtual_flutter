import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  DrawerButton(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Icon(icon),
              SizedBox(width: 20),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
