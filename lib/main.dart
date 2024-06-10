import 'package:flutter/material.dart';
import 'package:recipe/pages/home_page.dart';
import 'package:recipe/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )
        )
      ),
      initialRoute: "/login",
      routes: {
        "/login":(context) => LoginPage(),
        "/home":(context) => HomePage(),
      },
    );
  }
}
