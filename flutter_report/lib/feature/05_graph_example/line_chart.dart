part of 'graph_page.dart';

class _LineChart extends StatefulWidget {
  const _LineChart({Key? key}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<GraphInfo> list = [
    const GraphInfo('1', 10),
    const GraphInfo('2', 40),
    const GraphInfo('3', 20),
    const GraphInfo('4', 80),
    const GraphInfo('5', 70),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12,
            ),
            child: LineChart(
              _chartData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData _chartData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      maxX: list.length.toDouble(),
      maxY: 100,
      lineBarsData: _chartBarDate,
    );
  }

  List<LineChartBarData> get _chartBarDate =>[
    LineChartBarData(
      spots: [
        ...List.generate(list.length, (index) => FlSpot(index.toDouble(), list[index].ratio.toDouble())),
      ],
      isCurved: true,
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      barWidth: 5,
      dotData: FlDotData(
        checkToShowDot: (spot, barData) => spot.x == list.length - 1,
        getDotPainter: (spot, percent, bar, index) => _DotPainter(
          radius: 5.w,
          color: Colors.lightBlue,
          value: spot.y.round(),
        ),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: gradientColors
              .map((color) => color.withOpacity(0.3))
              .toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    ),
  ];
}
