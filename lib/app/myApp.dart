import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/controllerPages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lojinha do Mixéu',
      debugShowCheckedModeBanner: false,
      home: ControllerPage(),
      theme: ThemeData(
        scaffoldBackgroundColor:
            Color.fromARGB(255, 15, 15, 15),
        primaryColor: Color.fromARGB(255, 35, 35, 35),
        hintColor: Color.fromARGB(255, 230, 230, 230),
        appBarTheme: AppBarTheme(
            elevation: 0,
            textTheme: TextTheme(
                title: TextStyle(
                    color: Color.fromARGB(230, 230, 230, 230),
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        iconTheme: IconThemeData(
          color: Color.fromARGB(230, 230, 230, 230),
          size: 32,
        ),
        textTheme: TextTheme(
          title: TextStyle(
            color: Color.fromARGB(240, 230, 230, 230),
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          body1: TextStyle(
            color: Color.fromARGB(220, 220, 220, 220),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          body2: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
          ),


          display1: TextStyle(color: Colors.red),
          subtitle: TextStyle(color: Colors.red),
          button: TextStyle(color: Colors.red),
          caption: TextStyle(color: Colors.red),
          headline: TextStyle(color: Colors.red),
          subhead: TextStyle(color: Colors.red),
        ),
        accentColor: Colors.deepPurple, //???????
      ),
    );
  }
}
