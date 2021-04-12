import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gh_toy/maintab/main_tab_bloc.dart';
import 'package:gh_toy/maintab/main_tab_event.dart';
import 'package:gh_toy/maintab/main_tab_state.dart';
import 'package:gh_toy/post/post_bloc.dart';
import 'package:gh_toy/post/post_state.dart';
import 'package:gh_toy/post/post_widget.dart';

class PostScreen extends StatefulWidget {
  static const routeName = 'post';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostBloc postBloc;
  MainTabBloc mainTabBloc;
  static final _bottomNavigationItemList =
  <MainTab, _BottomNavigationItemModel>{
    MainTab.first: _BottomNavigationItemModel(
      label: '리포트',
      icon: SvgPicture.asset(
        'assets/images/ic_report_nor.svg',
        width: 24.0,
        height: 24.0,
      ),
      activeIcon: SvgPicture.asset(
        'assets/images/ic_report_active.svg',
        width: 24.0,
        height: 24.0,
      ),
    ),
    MainTab.second: _BottomNavigationItemModel(
      label: 'VAT',
      icon: SvgPicture.asset(
        'assets/images/ic_vat_nor.svg',
        width: 24.0,
        height: 24.0,
      ),
      activeIcon: SvgPicture.asset(
        'assets/images/ic_vat_active.svg',
        width: 24.0,
        height: 24.0,
      ),
    ),
    MainTab.third: _BottomNavigationItemModel(
      label: '캘린더',
      icon: SvgPicture.asset(
        'assets/images/ic_sales_nor.svg',
        width: 24.0,
        height: 24.0,
      ),
      activeIcon: SvgPicture.asset(
        'assets/images/ic_sales_active.svg',
        width: 24.0,
        height: 24.0,
      ),
    ),

  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postBloc = context.bloc<PostBloc>();
    mainTabBloc = context.bloc<MainTabBloc>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('post'),
      ),
      body: Text('dd'),
      bottomNavigationBar: BlocBuilder<MainTabBloc, MainTabState>(
        builder: (context, state) => BottomNavigationBar(
          currentIndex: MainTab.values.indexOf(state.tab),
          onTap: (index) => mainTabBloc.add(
            ChangeMainTab(tab: MainTab.values[index]),
          ),
          //onTap: (index){},
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          selectedItemColor: Color(0xff2962ff),
          selectedFontSize: 12.0,
          unselectedItemColor: Color(0xff222222),
          unselectedFontSize: 12.0,
          items: _bottomNavigationItemList
              .map<MainTab, BottomNavigationBarItem>(
                (tab, model) => MapEntry<MainTab, BottomNavigationBarItem>(
              tab,
              BottomNavigationBarItem(
                icon: MainTabBadgeWrapper(
                  child: model.icon,
                  badgeCount: 0,
                ),
                activeIcon: MainTabBadgeWrapper(
                  child: model.activeIcon,
                  badgeCount: 0,
                ),
                // title: Text(model.label),
                label: model.label,
              ),
            ),
          )
              .values
              .toList(),
        ),
      ),    );
  }
}
class _BottomNavigationItemModel extends Equatable {
  final String label;
  final Widget icon;
  final Widget activeIcon;

  const _BottomNavigationItemModel({
    this.label,
    this.icon,
    this.activeIcon,
  });

  @override
  String toString() => '''$_BottomNavigationItemModel {
    label: $label,
    icon: $icon,
    activeIcon: $activeIcon,
  }''';

  @override
  List<Object> get props => [
    label,
    icon,
    activeIcon,
  ];
}