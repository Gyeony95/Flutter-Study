import 'package:flutter/material.dart';
import 'package:gh_toy/login/login_screen.dart';
import 'package:gh_toy/post/post_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(context)=> LoginScreen(),
        PostScreen.routeName:(context)=> PostScreen(),
      },
    );
  }
}