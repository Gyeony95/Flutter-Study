import 'package:flutter/material.dart';
import 'package:flutter_report/feature/01_animation_example/animation_example_page.dart';
import 'package:flutter_report/feature/02_auto_scroll_with_tabbar_exmaple/auto_scroll_with_tabbar_page.dart';
import 'package:flutter_report/feature/03_color_change_appbar_example/color_change_appbar_page.dart';
import 'package:flutter_report/feature/04_image_page_slider_example/image_page_slider.dart';
import 'package:flutter_report/feature/05_graph_example/graph_page.dart';
import 'package:flutter_report/feature/06_expansion_child_example/expansion_child_page.dart';
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
            FeatureEnum.animation.route: (context) => const AnimationExample(),
            FeatureEnum.autoScrollWithTabBar.route: (context) => const AutoScrollWithTabbarPage(),
            FeatureEnum.colorChangeAppbar.route: (context) => const ColorChangeAppbarPage(),
            FeatureEnum.imagePageSlider.route: (context) => const ImagePageSlider(),
            FeatureEnum.graph.route: (context) => const GraphPage(),
            FeatureEnum.expansionChild.route: (context) => const ExpansionChildPage(),
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            _appBar(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _appBar(){
    return SliverAppBar(
      pinned: true,
      elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
      expandedHeight: 100.w,
      automaticallyImplyLeading: false,
      title: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xff03fadd),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.fadeTitle],
        collapseMode: CollapseMode.pin,
        background: Container(
          height: 120.w,
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.w),
              bottomRight: Radius.circular(12.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(){
    return SliverToBoxAdapter(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: FeatureEnum.values.length,
        itemBuilder : listItem,
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
  animation('/animation', '애니메이션'),
  autoScrollWithTabBar('/auto_scroll_with_tabBar', '탭바 스크롤 자동 이동'),
  colorChangeAppbar('/color_change_appbar', '스크롤시 색이 바뀌는 앱바'),
  imagePageSlider('/image_page_slider', '이미지 슬라이더'),
  graph('/graph', '그래프'),
  expansionChild('/expanded_child', '자식 확장 시키기');

  final String route;
  final String name;
  const FeatureEnum(this.route, this.name);

}
extension FeatureEnumExtention on FeatureEnum{
  VoidCallback onTap(BuildContext context) => (){Navigator.pushNamed(context, route);};
}