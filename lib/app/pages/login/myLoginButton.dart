import 'package:flutter/material.dart';

class MyLoginButton extends StatelessWidget {
  final TextStyle style;
  MyLoginButton(this.style);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromRGBO(110, 110, 110, 155),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text(
          "Entrar",
          textAlign: TextAlign.center,
          style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}
