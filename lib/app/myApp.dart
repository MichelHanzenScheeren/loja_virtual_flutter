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
        scaffoldBackgroundColor: Color.fromARGB(240, 30, 30, 30),
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          body2: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
          ),
          subhead: TextStyle(
            color: Color.fromARGB(220, 220, 220, 220),
            fontSize: 25,
          ),


          display1: TextStyle(color: Colors.yellow),
          button: TextStyle(color: Colors.yellow),
          caption: TextStyle(color: Colors.yellow),
          headline: TextStyle(color: Colors.yellow),

        ),
        accentColor: Colors.deepPurple, //???????
      ),
    );
  }
}
