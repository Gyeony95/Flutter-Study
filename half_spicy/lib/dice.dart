import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDice = 1;
  int rightDice = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('dice game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Row(
                children: [
                  Expanded(
                    //flex: 2,//weight와 같은 개념인듯
                      child: Image.asset('image/dice$leftDice.png')),//Expanded는 가능한 모든 공간을 차지함
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Image.asset('image/dice$rightDice.png')),
                ],
              ),
            ),
            SizedBox(height: 60,),
            ButtonTheme(
              minWidth: 100,
              height: 60,
              child: RaisedButton(
                child: Icon(Icons.play_arrow,
                color: Colors.white,
                size: 50.0,),
                color: Colors.orangeAccent,
                  onPressed: (){
                  setState(() {
                    leftDice = Random().nextInt(6)+1;
                    rightDice = Random().nextInt(6)+1;
                    showToast('left dice : $leftDice , right dice : $rightDice');
                    //print('left dice : $leftDice , right dice : $rightDice');
                  });
                  }),
            )
          ],
        ),
      ),
    );
  }
}

showToast(String data){
  Fluttertoast.showToast(
    textColor: Colors.black,
      msg: data,
  backgroundColor: Colors.white,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM);
}