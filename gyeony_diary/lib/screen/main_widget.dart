import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final Color mColor;

  const MainHeader({this.mColor});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      color: mColor,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Home',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
