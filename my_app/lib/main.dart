// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/ScreenA.dart';
import 'package:my_app/ScreenB.dart';
import 'package:my_app/ScreenC.dart';


// 메인 함수 실행하면 최상위 함수인 런앱 실행, 런앱 안에는 위젯이 있어야함
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false, //디버드 띠 없애기
      //title: "Appbar",
      initialRoute: '/',//기본 주소
      routes: {
        '/' : (context) => ScreenA(),
        '/b' : (context) => ScreenB(),
        '/c' : (context) => ScreenC(),
      },
      theme: ThemeData(primarySwatch: Colors.red // 테마 기본 색상이 블루라는 의미
          ),
    );
  }
}

class NavigatorEX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fisrt page"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("go to the second page"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SecondPage()));//필요없는 매개변수를 사용할 때 '_' 를 사용함
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second page"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("go to the first page"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class ColumnRowEX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Row(
            //verticalDirection: VerticalDirection.up,//역순정렬
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,//같은 간격을 가짐
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,//상중하에 배치
            //crossAxisAlignment: CrossAxisAlignment.end,//가로축 끝 정렬
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //컬럼 하위 위젯들 모두 가로(or 세로)에 꽉차게 맞춰줌(width 속성 다 지워줘야함)
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
              SizedBox(
                width: 30.0,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ],
          ),
        ));
  }
}

class ContainerEX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        //위젯이 화면 밖으로 빠져나가는것을 방지하는 위젯
        child: Container(
          //child가 없는경우 컨테이너는 최대한의 자리를 차지함, 자식을 가지게되면 컨테이너는 자식의 크기로 줄어든다.
          child: Text('hello'),
          width: 100,
          height: 100,
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          padding: EdgeInsets.all(40),
          color: Colors.redAccent,
        ),
      ),
    );
  }
}

class ToastEX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("toast"),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            flutterToast();
          },
          child: Text("Toast"),
          color: Colors.blue,
        ),
      ),
    );
  }
}

void flutterToast() {
  Fluttertoast.showToast(
    msg: "flutter",
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.redAccent,
    fontSize: 20.0,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

class SnackBarEX2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Snack Bar"),
          centerTitle: true,
        ),
        body: MyScnackBar());
  }
}

class MyScnackBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text('show me'),
          onPressed: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'hello',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.teal,
                duration: Duration(milliseconds: 1000),
              ),
            );
          }),
    );
  }
}

class SnackBarEX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Snack Bar"),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext ctx) {
            return Center(
              child: FlatButton(
                //입체감 없는 납작한 버튼
                child: Text(
                  "show me",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () {
                  Scaffold.of(ctx)
                      .showSnackBar(SnackBar(content: Text("'hello")));
                },
              ),
            );
          },
        ));
  }
}

class DrawerEX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appbar icon menu"),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          //복수의 아이콘 버튼을 오른쪽에 배치할 때
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //버튼 클릭했을때 이벤트 정의 하는곳
              print('shopping_cart button is clicked');
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('search button is clicked');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              //보통 사용자 정보가 들어가는 상단 박스를 드로어 헤더라고 함
              currentAccountPicture: CircleAvatar(
                //내 이미지
                backgroundImage: AssetImage('assets/mphoto.jpg'),
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: <Widget>[
                //다른 이미지들
                CircleAvatar(
                  backgroundImage: AssetImage('assets/flutter_logo.png'),
                  backgroundColor: Colors.white,
                ),
              ],
              accountName: Text("Gyeony"),
              accountEmail: Text("rlg1133@namver.com"),
              onDetailsPressed: () {
                print("arrow is clicked");
              },
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: BorderRadius.only(
                      //밑에 둥글게 하는 부분
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.grey[850]),
              title: Text('home'),
              onTap: () {
                print('home clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey[850]),
              title: Text('settings'),
              onTap: () {
                print('settings clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.question_answer, color: Colors.grey[850]),
              title: Text('question_answer'),
              onTap: () {
                print('question_answer clicked');
              },
              trailing: Icon(Icons.add),
            )
          ],
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start, //시작점 정렬을 위한 부분
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/mphoto.jpg'),
                radius: 60.0,
              ),
            ),
            Divider(
              //위아래 합쳐서 60만큼 떨어지게 설계한다는 의미
              height: 60.0,
              color: Colors.grey[850],
              thickness: 0.5,
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              //위젯간에 간격을 두기 위함
              height: 10.0,
            ),
            Text(
              'BBANTO',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              //위젯간에 간격을 두기 위함
              height: 30.0,
            ),
            Text(
              'BBANTO POWER LAVEL',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              //위젯간에 간격을 두기 위함
              height: 10.0,
            ),
            Text(
              '14',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              //위젯간에 간격을 두기 위함
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  //위젯간에 간격을 두기 위함
                  width: 10.0,
                ),
                Text(
                  'using lightsaber',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  //위젯간에 간격을 두기 위함
                  width: 10.0,
                ),
                Text(
                  'face hero tattoo',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(
                  //위젯간에 간격을 두기 위함
                  width: 10.0,
                ),
                Text(
                  'fire flames',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),
                ),
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
    return Scaffold(
      //발판을 만들어준다는 의미
      appBar: AppBar(
        title: Text("BBANTO"),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0.0, //앱바 밑에 그림자 값 지정
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,//정렬을 위한 위젯
          children: <Widget>[Text('data'), Text('data'), Text('data')],
        ),
      ),
    );
  }
}
