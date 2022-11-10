import 'package:flutter/material.dart';
import 'package:flutter_report/feature/08_stackable_list/stackable_list.dart';
import 'package:flutter_report/feature/main_frame.dart';
import 'package:flutter_report/main.dart';

class StackableListPage extends StatefulWidget {
  const StackableListPage({Key? key}) : super(key: key);

  @override
  State<StackableListPage> createState() => _StackableListPageState();
}

class _StackableListPageState extends State<StackableListPage>{
  @override
  Widget build(BuildContext context) {
    return MainFrame(
      route: FeatureEnum.stackableList,
      child: StackableList(
        builder: (context, index) {
          return Image.asset(
            'assets/images/image_${index+1 >= 10 ? index+1 : '0${index+1}'}.jpeg',
            width: MediaQuery.of(context).size.width,
            height: 100,
            fit: BoxFit.cover,
          );
        }, itemExtent: 200, itemCount: 10,),
    );
  }

}
