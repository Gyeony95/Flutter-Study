import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_report/feature/02_auto_scroll_with_tabbar_exmaple/anchor_posotion_mixin.dart';
import 'package:flutter_report/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'tabbar_enum.dart';
part 'auto_tab_persistent_delegate.dart';

class AutoScrollWithTabbarPage extends StatefulWidget {
  const AutoScrollWithTabbarPage({Key? key}) : super(key: key);

  @override
  State<AutoScrollWithTabbarPage> createState() => _AutoScrollWithTabbarPageState();
}

class _AutoScrollWithTabbarPageState extends State<AutoScrollWithTabbarPage>
    with TickerProviderStateMixin, AnchorPositionMixin{

  /// 커스텀 스크롤뷰 컨트롤러
  late ScrollController scrollController;

  /// 선택된 탭
  var initialIndex = TabBarCategory.first;
  late TabController tabController;

  /// ### 탭바의 높이값.
  double tabBarExtent = 46.w;

  /// 각 아이템 임의의 너비값
  double areaWidth = 360.w;

  /// 각 아이템 임의의 높이값
  double areaHeight = 500.w;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    tabController = TabController(
      length: TabBarCategory.values.length,
      vsync: this,
    );
  }

  void _scrollListener() {
    if (!scrollController.hasClients) {
      return;
    }
    final position = scrollController.offset;
    setState(() {});
    // 앵커 위치 리스너
    anchorListener(position);
  }

  @override
  Widget build(BuildContext context) {
    // 포스트 프레임 콜백으로 빌드 직후 포지션 갱신
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      postFrameCallback();
    });

    return Scaffold(
      appBar: AppBar(title: Text(FeatureEnum.autoScrollWithTabBar.name),),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: scrollController,
        slivers: [
          _tabBar(),
          ...List.generate(TabBarCategory.values.length,
                  (index) => _area(TabBarCategory.values[index]),
          )
        ],
      ),
    );
  }

  Widget _tabBar() => SliverPersistentHeader(
    pinned: true,
    delegate: _AutoTabPersistentDelegate(
      tabController: tabController,
      onTapTabItem: onTapTabItem,
      extent: tabBarExtent,
    ),
  );


  Widget _area(TabBarCategory tabBar){
    return SliverToBoxAdapter(
      child: Container(
        key: getKey(tabBar),
        color: tabBar.color,
        width: areaWidth,
        height: areaHeight,
      ),
    );
  }

  GlobalKey getKey(TabBarCategory tabBar){
    switch(tabBar){
      case TabBarCategory.first:
        return firstKey;
      case TabBarCategory.second:
        return secondKey;
      case TabBarCategory.third:
        return thirdKey;
    }
  }

  void postFrameCallback() {
    Timer(const Duration(milliseconds: 50), () {
      var scrollPosition = 0.0;
      if (scrollController.hasClients) {
        scrollPosition = scrollController.offset;
      }
      checkPosition(scrollPosition);
    });
  }

  @override
  void onChangeProperTab(TabBarCategory tabItem) {
    switch (tabItem) {
      case TabBarCategory.first:
        tabController.animateTo(0);
        break;
      case TabBarCategory.second:
        tabController.animateTo(1);
        break;
      case TabBarCategory.third:
        tabController.animateTo(2);
        break;
    }
  }

  @override
  double get revision => MediaQuery.of(context).viewPadding.top + kToolbarHeight + tabBarExtent;

  @override
  void shouldMoveScroll(double position) {
    scrollController.animateTo(
      position,
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }
}
