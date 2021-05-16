import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/widgets/common_button.dart';

import 'join_widget.dart';


class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'is first'
        ),
      ),
      body: SafeArea(
    child: Container(
    child: Column(
        children: [
        LoginBody(),
    ],
    ),
    ),
    )
    );
  }
}
