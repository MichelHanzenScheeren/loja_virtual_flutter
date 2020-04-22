import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/user/commonWidgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/pages/user/commonWidgets/myTextFormField.dart';
import 'package:lojavirtualflutter/app/pages/user/createAccount/myUserTerms.dart';
import 'package:lojavirtualflutter/app/pages/user/validators.dart';

class CreateAccount extends StatelessWidget {
  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.white,
  );
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  String confirmPasswordValidator(String text) {
    if (text.length < 8) {
      return "A senha deve ter pelo menos 8 caracters.";
    } else if (text != passwordController.text) {
      return "As senhas não são iguais!";
    }
    else {
      return null;
    }
  }

  void doCreateAccount() {
    if(formKey.currentState.validate()) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    MyTextFormField(
                      text: "Nome:",
                      style: style,
                      validator: Validator.basicValidator,
                    ),
                    SizedBox(height: 15.0),
                    MyTextFormField(
                      text: "Sobrenome:",
                      style: style,
                      validator: Validator.basicValidator,
                    ),
                    SizedBox(height: 15.0),
                    MyTextFormField(
                      text: "Email:",
                      style: style,
                      validator: Validator.emailValidator,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15.0),
                    MyTextFormField(
                      text: "Senha:",
                      style: style,
                      validator: Validator.passwordValidator,
                      obscure: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: 15.0),
                    MyTextFormField(
                      text: "Confirme sua senha:",
                      style: style,
                      validator: confirmPasswordValidator,
                      obscure: true,
                    ),
                    SizedBox(height: 20.0),
                    MyUserTerms(style),
                    SizedBox(height: 20.0),
                    MyOkButton("Criar conta", style, doCreateAccount),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
