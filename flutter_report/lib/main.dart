import 'package:flutter/material.dart';
import 'package:flutter_report/feature/01_animation_example/animation_example_page.dart';
import 'package:flutter_report/feature/02_auto_scroll_with_tabbar_exmaple/auto_scroll_with_tabbar_page.dart';
import 'package:flutter_report/feature/03_color_change_appbar_example/color_change_appbar_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,690),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const FeatureList(),
            FeatureEnum.animationExample.route: (context) => const AnimationExample(),
            FeatureEnum.autoScrollWithTabBar.route: (context) => const AutoScrollWithTabbarPage(),
            FeatureEnum.colorChangeAppbar.route: (context) => const ColorChangeAppbarPage(),
          },

        );
      },
    );
  }
}

class FeatureList extends StatefulWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('플러터 기능 리스트'),),
      body: SafeArea(
        child: ListView.builder(
          itemCount: FeatureEnum.values.length,
          itemBuilder : listItem,
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, int index){
    var currentFeature = FeatureEnum.values[index];
    return GestureDetector(
      onTap: currentFeature.onTap(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        child: Text(currentFeature.name, style: const TextStyle(
          fontSize: 20,
        ),),
      ),
    );
  }
}


enum FeatureEnum{
  animationExample('/animation_example', '애니메이션 예제'),
  autoScrollWithTabBar('/auto_scroll_with_tabBar', '탭바 스크롤 자동 이동'),
  colorChangeAppbar('/color_change_appbar', '스크롤시 색이 바뀌는 앱바');

  final String route;
  final String name;
  const FeatureEnum(this.route, this.name);

}
extension FeatureEnumExtention on FeatureEnum{
  VoidCallback onTap(BuildContext context) => (){Navigator.pushNamed(context, route);};
}