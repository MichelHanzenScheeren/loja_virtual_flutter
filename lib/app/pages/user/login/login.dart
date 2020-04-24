import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/user/commonWidgets/myTextFormField.dart';
import 'package:lojavirtualflutter/app/pages/user/login/myCreateAccountButton.dart';
import 'package:lojavirtualflutter/app/pages/user/login/myForgetPasswordButton.dart';
import 'package:lojavirtualflutter/app/pages/user/commonWidgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/pages/user/validators.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<User>(builder: (context, child, model) {
        void doLogin() {
          if (formKey.currentState.validate()) {
            model.logIn();
          }
        }

        if (model.isLoading) return WaitingWidget(width: 50, height: 50);

        return Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    MyTextFormField(
                      text: "Email:",
                      style: style,
                      validator: Validator.emailValidator,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10.0),
                    MyTextFormField(
                      text: "Senha:",
                      style: style,
                      validator: Validator.passwordValidator,
                      obscure: true,
                    ),
                    MyForgetPasswordButton(style),
                    SizedBox(height: 20.0),
                    MyOkButton("Entrar", style, doLogin),
                    SizedBox(height: 30.0),
                    MyCreateAccountButton(style),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
