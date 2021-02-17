import 'package:flutter/material.dart';

// 메인 함수 실행하면 최상위 함수인 런앱 실행, 런앱 안에는 위젯이 있어야함
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "First App",
      theme: ThemeData(
        primarySwatch: Colors.blue// 테마 기본 색상이 블루라는 의미
      ),
    home : MyHomePage(),
    );
  }
}

//원래 내부에 데이터가 바뀌는 부분이 하나라도 있으면 스테이트풀로 해야하는데 지금은 스테이트리스
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(//발판을 만들어준다는 의미
      appBar: AppBar(
        title: Text("First App"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Hello'),
            Text('Hello'),
            Text('Hello')
          ],
        ),
      ),
    );
  }
}
