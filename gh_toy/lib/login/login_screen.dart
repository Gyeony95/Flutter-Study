import 'package:flutter/material.dart';
import 'package:gh_toy/login/login_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Center(
        child: LoginBody()
      ),
    );
  }
}
