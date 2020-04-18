import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/myHomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lojinha do Mixéu',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 15, 15, 15), // Cinza escuro
        primaryColor: Color.fromARGB(255, 35, 35, 35), // Cinza claro
        hintColor: Color.fromARGB(255, 230, 230, 230), // Branco neutro
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              color: Color.fromARGB(230, 230, 230, 230), // Branco neutro
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(230, 230, 230, 230), // Branco neutro
        ),


        accentColor: Colors.deepPurple, //???????
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.red), // ???????
          body2: TextStyle(color: Colors.red), // ???????
          display1: TextStyle(color: Colors.red), // ???????
          title: TextStyle(color: Colors.red), // ???????
          subtitle: TextStyle(color: Colors.red), // ???????
          button: TextStyle(color: Colors.red), // ???????
          caption: TextStyle(color: Colors.red), // ???????
          headline: TextStyle(color: Colors.red), // ???????
          subhead: TextStyle(color: Colors.red), // ???????
        ),
      ),
    );
  }
}
