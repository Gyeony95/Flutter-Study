import 'package:flutter/material.dart';
import 'package:flutter_web_study/edit/edit_screen.dart';
import 'package:flutter_web_study/home/home_screen.dart';
import 'package:flutter_web_study/signup/signup_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/welcome': (context) => EditScreen(),
      },
    );
  }
}

