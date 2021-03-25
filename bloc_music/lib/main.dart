import 'package:bloc_music/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
