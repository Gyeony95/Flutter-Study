import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_report/feature/05_graph_example/graph_info.dart';
import 'package:flutter_report/feature/main_frame.dart';
import 'package:flutter_report/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'line_chart.dart';
part 'dot_painter.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {

  List<GraphInfo> list = [
    const GraphInfo('첫번째 값', 10),
    const GraphInfo('두번째 값', 40),
    const GraphInfo('세번째 값', 99),
    const GraphInfo('네번째 값', 30),
    const GraphInfo('다섯번째 값', 20),
  ];

  @override
  Widget build(BuildContext context) {
    return MainFrame(route: FeatureEnum.graph,
        child: buildBody(),
    );
  }

  Widget buildBody(){
    return Column(
      children: const [
        _LineChart()
      ],
    );
  }

}
