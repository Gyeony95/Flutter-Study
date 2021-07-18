import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:gyeony_diary/bloc/main_bloc.dart';
import 'package:gyeony_diary/bloc/main_event.dart';
import 'package:gyeony_diary/bloc/main_state.dart';
import 'package:gyeony_diary/model/chart_model.dart';
import 'package:gyeony_diary/widget/custom_clamping_scroll_physics.dart';
import 'package:gyeony_diary/widget/flare_progress.dart';
import 'package:gyeony_diary/widget/manu_widget.dart';
import 'package:gyeony_diary/widget/nomal_refresh_header.dart';
import 'package:gyeony_diary/widget/shadowed_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'main_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainBloc _mainBloc;
  final _refreshController = RefreshController(initialRefresh: false);
  static final _mainColor = const Color(0xff867ae9);

  @override
  void initState() {
    super.initState();
    _mainBloc = context.read<MainBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('일기를 써보아요'),
        // ),
        body: BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainLoaded) {
          _refreshController.refreshCompleted();
        }
      },
      builder: (context, state) {
        if (state is MainLoading) {
          return Center(child: FlareProgress());
        }
        if (state is MainLoaded) {
          return Ink(
            color: _mainColor,
            child: LayoutBuilder(
                builder: (context, constraints) => SmartRefresher(
                      enablePullDown: true,
                      header: NormalRefreshHeader(),
                      physics: CustomClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                        canUnderscroll: true,
                        canOverscroll: false,
                      ),
                      controller: _refreshController,
                      onRefresh: () => _mainBloc.add(GetDailyDiaryData()),
                      child: SliderMenuContainer(
                        //appBarColor: _mainColor,
                        sliderMenuOpenSize: 200,
                        // title: Text(
                        //   'ddddd',
                        //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                        // ),
                        hasAppBar: false,
                        sliderMenu: MenuWidget(
                          onItemClick: (title) {
                            // _key.currentState!.closeDrawer();
                            // setState(() {
                            //   this.title = title;
                            // });
                          },
                        ),
                        sliderMain: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MainHeader(mColor : _mainColor),

                                Text('목표'),
                                ShadowedCard(
                                  margin: EdgeInsets.all(20),
                                  child: BarChartSample(),

                                  // child: SfCircularChart(
                                  //     title:
                                  //         ChartTitle(text: '오늘 일기는 이만큼 쓰셧어요!'),
                                  //     //legend: Legend(isVisible: true),
                                  //     series: <
                                  //         RadialBarSeries<RadialData, String>>[
                                  //       RadialBarSeries<RadialData, String>(
                                  //           maximumValue: 100,
                                  //           cornerStyle: CornerStyle.bothCurve,
                                  //           dataSource: state.list,
                                  //           xValueMapper:
                                  //               (RadialData data, _) =>
                                  //                   data.xData,
                                  //           yValueMapper:
                                  //               (RadialData data, _) =>
                                  //                   data.yData,
                                  //           dataLabelMapper:
                                  //               (RadialData data, _) =>
                                  //                   data.text,
                                  //           dataLabelSettings:
                                  //               DataLabelSettings(
                                  //                   isVisible: true)),
                                  //     ]),
                                ),

                                // ShadowedCard(
                                //     child:
                                // ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: InkResponse(
                                    child:
                                        Center(child: Text('여기를 눌러 일기를 써보세요!')),
                                    onTap: () => Get.toNamed('/post'),
                                  ),
                                )
                              ],
                            )),
                      ),
                    )),
          );
        }
        return Container();
      },
    ));
  }
}
