import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/widgets/common_button.dart';


class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline3,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            CommonButton(onPressed: (){
              createRecord ();
              Get.toNamed('/main');
            }, text: 'login'),
          ],
        ),
      ),
    );
  }
  void createRecord () {
    databaseReference .child ( "1" ) .set ({
      'title' : 'Mastering EJB' ,
      'description' : 'Programming Guide for J2EE'
    });
    databaseReference .child ( "2" ) .set ({
      'title' : 'Flutter in Action' ,
      'description' : 'Flutter를 배우기위한 완전한 프로그래밍 가이드'
    });
  }
  void getData () {
    databaseReference .once (). then ((DataSnapshot snapshot) {
    print ( 'Data : ${snapshot. value } ' );
    });
  }
}
