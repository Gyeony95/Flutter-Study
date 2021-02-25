import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'future',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = 'no data found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('future test'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  onPressed: (){futureTest();},
                  child: Text('future test',
                  style: TextStyle(fontSize: 20.0),),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                result,
                style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
              )
            ],
          ),
        ),
      ),
    );
  }

  futureTest(){
    Future.delayed(Duration(seconds: 3))
        .then((value) => setState((){this.result = 'the data is fetched';}));
  }
}

