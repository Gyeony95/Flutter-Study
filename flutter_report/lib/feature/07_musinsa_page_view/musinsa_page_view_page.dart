import 'package:flutter/material.dart';
import 'package:flutter_report/feature/07_musinsa_page_view/custom_carousel.dart';
import 'package:flutter_report/feature/07_musinsa_page_view/musinsa_stacked_list.dart';
import 'package:flutter_report/feature/main_frame.dart';
import 'package:flutter_report/main.dart';

class MusinsaPageViewPage extends StatefulWidget {
  const MusinsaPageViewPage({Key? key}) : super(key: key);

  @override
  State<MusinsaPageViewPage> createState() => _MusinsaPageViewPageState();
}

class _MusinsaPageViewPageState extends State<MusinsaPageViewPage> {

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      route: FeatureEnum.musinsaPageView,
      child: MusinsaStackedList(
        scrollDirection: Axis.horizontal,
        physics: CustomScrollPhysics(
          itemDimension: MediaQuery.of(context).size.width,
        ),
        widthFactor: 1.0,
        builder: (context, index) {
          return Image.asset(
            'assets/images/image_${index+1 >= 10 ? index+1 : '0${index+1}'}.jpeg',
            width: MediaQuery.of(context).size.width,
            height: 100,
            fit: BoxFit.cover,
          );
        }, itemExtent: MediaQuery.of(context).size.width, itemCount: 10,),
    );
  }
}
