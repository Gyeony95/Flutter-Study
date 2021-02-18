import 'package:flutter/material.dart';

// 메인 함수 실행하면 최상위 함수인 런앱 실행, 런앱 안에는 위젯이 있어야함
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//디버드 띠 없애기
      title: "Character Card",
      home: Grade(),
      theme: ThemeData(
        primarySwatch: Colors.blue// 테마 기본 색상이 블루라는 의미
      ),
    );
  }
}

class Grade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[800],
      appBar: AppBar(
        title: Text('BBANTO'),
        backgroundColor: Colors.amber[700],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,//시작점 정렬을 위한 부분
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/mphoto.jpg'),
                radius: 60.0,
              ),
            ),
            Divider(//위아래 합쳐서 60만큼 떨어지게 설계한다는 의미
              height: 60.0,
              color: Colors.grey[850],
              thickness: 0.5,
            ),
            Text('NAME',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2.0,
            ),
            ),
            SizedBox(//위젯간에 간격을 두기 위함
              height: 10.0,
            ),
            Text('BBANTO',
              style:TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold
              ) ,),
            SizedBox(//위젯간에 간격을 두기 위함
              height: 30.0,
            ),
            Text('BBANTO POWER LAVEL',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(//위젯간에 간격을 두기 위함
              height: 10.0,
            ),
            Text('14',
              style:TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
              ) ,
            ),
            SizedBox(//위젯간에 간격을 두기 위함
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(//위젯간에 간격을 두기 위함
                  width: 10.0,
                ),
                Text('using lightsaber',
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(//위젯간에 간격을 두기 위함
                  width: 10.0,
                ),
                Text('face hero tattoo',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(//위젯간에 간격을 두기 위함
                  width: 10.0,
                ),
                Text('fire flames',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),),
              ],
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/flutter_logo.png'),
                radius: 40.0,
                backgroundColor: Colors.amber[800],
              ),
            )
          ],
        ),
      ),
    );
  }
}


//원래 내부에 데이터가 바뀌는 부분이 하나라도 있으면 스테이트풀로 해야하는데 지금은 스테이트리스
class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(//발판을 만들어준다는 의미
      appBar: AppBar(
        title: Text("BBANTO"),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0.0,//앱바 밑에 그림자 값 지정
      ),
      body:  Center(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,//정렬을 위한 위젯
            children: <Widget>[
                Text('data'),
                Text('data'),
                Text('data')
            ],
        ),
      ),


    );
  }
}
