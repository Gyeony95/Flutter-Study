import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScreenA"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.red,
              child: Text("go to screenB"),
              onPressed: () {
                Navigator.pushNamed(context, '/b');
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text("go to screenC"),
              onPressed: () {
                Navigator.pushNamed(context, '/c');
              },
            )
          ],
        ),
      ),
    );
  }
}
