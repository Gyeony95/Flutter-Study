import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('데일리 투데이'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height* 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width *0.8,
              height: MediaQuery.of(context).size.height* 0.2,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('당신도 친구를 낚는 뉴스로 강태공이 될 수 있습니다.', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Text('지금 바로 당신만의 새로운 뉴스를 만들어 보세요!', style: TextStyle(fontSize: 20),),
                  SizedBox(
                    height: 10,
                  ),
                  InkResponse(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.all(10),
                        child: Text('새로운 뉴스 만들기', style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),
                    ),
                    onTap: _showWelcomeScreen,
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: const Color(0xf0f0f0f0),
                borderRadius: BorderRadius.circular(10),

              ),
            )
          ],
        ),
      ),
    );
  }

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }
}
