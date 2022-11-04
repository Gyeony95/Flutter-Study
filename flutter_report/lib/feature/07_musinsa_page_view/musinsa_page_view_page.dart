import 'package:flutter/material.dart';
import 'package:flutter_report/feature/07_musinsa_page_view/custom_carousel.dart';
import 'package:flutter_report/feature/main_frame.dart';
import 'package:flutter_report/main.dart';

class MusinsaPageViewPage extends StatefulWidget {
  const MusinsaPageViewPage({Key? key}) : super(key: key);

  @override
  State<MusinsaPageViewPage> createState() => _MusinsaPageViewPageState();
}

class _MusinsaPageViewPageState extends State<MusinsaPageViewPage> with TickerProviderStateMixin {

  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // print(_controller.offset); // <-- This is it.
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      route: FeatureEnum.musinsaPageView,
      child: _buildBody(),
    );
  }

  // Widget _buildBody(){
  //   return ListView.builder(
  //     controller: _controller,
  //     scrollDirection: Axis.horizontal,
  //     itemCount: 10,
  //     physics: CustomScrollPhysics(
  //       itemDimension: MediaQuery.of(context).size.width,
  //     ),
  //     itemBuilder:(context, index){
  //       return Image.asset(
  //           'assets/images/image_${index+1 >= 10 ? index+1 : '0${index+1}'}.jpeg',
  //         width: MediaQuery.of(context).size.width,
  //         height: 100,
  //         fit: BoxFit.cover,
  //       );
  //     },
  //   );
  // }

  Widget _buildBody(){
    return ListView.builder(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      physics: CustomScrollPhysics(
        itemDimension: MediaQuery.of(context).size.width,
      ),
      itemBuilder:(context, index){
        return Image.asset(
          'assets/images/image_${index+1 >= 10 ? index+1 : '0${index+1}'}.jpeg',
          width: MediaQuery.of(context).size.width,
          height: 100,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
