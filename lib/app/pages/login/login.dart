import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/login/myForgetPasswordButton.dart';
import 'package:lojavirtualflutter/app/pages/login/myCreateAccount.dart';
import 'package:lojavirtualflutter/app/pages/login/myLoginButton.dart';
import 'package:lojavirtualflutter/app/pages/login/myTextFormField.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15.0),
                MyTextFormField("Email:", style,
                    type: TextInputType.emailAddress),
                SizedBox(height: 15.0),
                MyTextFormField("Senha:", style, obscure: true),
                MyForgetPasswordButton(style),
                SizedBox(height: 25.0),
                MyLoginButton(style),
                SizedBox(height: 40.0),
                MyCreateAccountButton(style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
