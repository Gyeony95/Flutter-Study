import 'package:flutter/material.dart';
import 'package:flutter_report/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorChangeAppbarPage extends StatefulWidget {
  const ColorChangeAppbarPage({Key? key}) : super(key: key);

  @override
  State<ColorChangeAppbarPage> createState() => _ColorChangeAppbarPageState();
}

class _ColorChangeAppbarPageState extends State<ColorChangeAppbarPage>
    with TickerProviderStateMixin{
  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _colorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    //색상 설정, 투명 -> 검정
    _colorTween =
        ColorTween(begin: Colors.transparent, end: const Color(0xFF1b1b1b))
            .animate(_colorAnimationController);
  }

  /// ### 스크롤시 앱바의 색상을 투명 -> 검은색으로 바꿔주기 위한 이벤트 리스너
  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 130);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              buildBody(),
              positionAppBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(){
    return SingleChildScrollView(
      child: Container(
        height: 2000.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black54,
              Colors.white,
            ],
          )
        ),
      ),
    );
  }

  Widget positionAppBar() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: statusBarHeight + kToolbarHeight, // 상단바 + AppBar 높이
      child: AnimatedBuilder(
        animation: _colorAnimationController,
        builder: (context, build) => AppBar(
          title: Text(FeatureEnum.colorChangeAppbar.name),
          backgroundColor: _colorTween.value, //appBar 투명색
          elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
        ),
      ),
    );
  }
}
