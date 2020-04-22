import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/user.dart';
import 'package:lojavirtualflutter/app/pages/controllerPages.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
      model: User(),
      child: MaterialApp(
        title: 'Lojinha do Mixéu',
        debugShowCheckedModeBanner: false,
        home: ControllerPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(240, 30, 30, 30),
          primaryColor: Color.fromARGB(255, 50, 50, 50),
          hintColor: Color.fromARGB(255, 230, 230, 230),
          iconTheme: IconThemeData(
            color: Color.fromARGB(230, 230, 230, 230),
            size: 32,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent,
            disabledColor: Color.fromARGB(255, 50, 50, 50),
          ),
          textTheme: TextTheme(
            title: TextStyle(
              color: Color.fromARGB(255, 245, 245, 245),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextStyle(
              color: Color.fromARGB(245, 240, 240, 240),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            body1: TextStyle(
              color: Color.fromARGB(220, 220, 220, 220),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            body2: TextStyle(
              color: Colors.blueAccent,
              fontSize: 22,
            ),
            subhead: TextStyle(
              color: Color.fromARGB(220, 220, 220, 220),
              fontSize: 25,
            ),
            display1: TextStyle(
              color: Color.fromARGB(220, 220, 220, 220),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            display2: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
