import 'package:flutter/material.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';

class GrowthChartWidget extends StatefulWidget {
  @override
  _GrowthChartWidgetState createState() => _GrowthChartWidgetState();
}

class _GrowthChartWidgetState extends State<GrowthChartWidget> {
  var chart;
  Map<DateTime, double> data = {};

  @override
  void initState() {
    super.initState();

    int currentYear = DateTime.now().year;
    double growthPercentage = 10.0;
    for (int i = 0; i < 10; i++) {
      Map<DateTime, double> yearData = {};
      yearData[DateTime(currentYear - i)] =
          (i % 2 == 0) ? growthPercentage : growthPercentage * 2;
      growthPercentage += 10;
      data.addAll(yearData);
    }

    chart = LineChart.fromDateTimeMaps([
      data
    ], [
      Colors.blue
    ], [
      '%',
    ], tapTextFontWeight: FontWeight.w400);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLineChart(
      chart,
      key: UniqueKey(),
      gridColor: const Color.fromARGB(255, 202, 202, 202),
      toolTipColor: Colors.black,
    );
    // Container(
    //   width: 500,
    //   height: 200,
    //   padding: EdgeInsets.all(16.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(12.0),
    //     color: Colors.grey[200],
    //   ),
    //   child: Padding(
    //     padding: EdgeInsets.all(10),
    //     child: AnimatedLineChart(
    //         chart,
    //         key: UniqueKey(), gridColor: const Color.fromARGB(255, 202, 202, 202), toolTipColor: Colors.black,
    //       ),

    //   ),
    // );
  }
}
