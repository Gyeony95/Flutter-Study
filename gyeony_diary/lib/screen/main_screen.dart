import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일기를 써보아요'),
      ),
      body:  Container(
          child: Column(
              children: [
                Text('작성된 일기가 없습니다!'),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: InkResponse(
                    child: Center(child: Text('여기를 눌러 일기를 써보세요!')),
                    onTap: ()=> Get.toNamed('/post'),
                  ),
                )
              ],
          )
      )
    );
  }
}

