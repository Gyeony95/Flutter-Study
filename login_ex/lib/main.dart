import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Login app',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: LogIn(),
    );
  }
}

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sing In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
              height: 50.0,
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //요소들을 가운데 두기위해
                  children: [
                    Image.asset('images/google.png'),
                    Text(
                      'login with google',
                      style: TextStyle(color: Colors.black87, fontSize: 15.0),
                    ),
                    Opacity(
                      //투명도를 조정해줌
                      opacity: 0.0,
                      child: Image.asset('images/google.png'),
                    ),
                  ],
                ),
                color: Colors.white,
                onPressed: (){

                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
