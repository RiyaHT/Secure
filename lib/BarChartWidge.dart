import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<OrdinalData> ordinalList = [
    OrdinalData(domain: '2019', measure: 120),
    OrdinalData(domain: '2020', measure: 220),
    OrdinalData(domain: '2021', measure: 440),
    OrdinalData(domain: '2022', measure: 500),
  ];

  var ordinalGroup;

  void initState() {
    super.initState();
    ordinalGroup = [
      OrdinalGroup(
        id: '1',
        chartType: ChartType.bar,
        data: ordinalList,
      ),
      OrdinalGroup(
        id: '2',
        chartType: ChartType.line,
        data: ordinalList,
      ),
      OrdinalGroup(
        id: '3',
        chartType: ChartType.scatterPlot,
        data: ordinalList,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DChartComboO(
      groupList: ordinalGroup,
    );
    // Container(
    //   width: 500,
    //   height: 200,
    //   padding: EdgeInsets.all(16.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(12.0),
    //     color: Colors.grey[200],
    //   ),
    //   child: AspectRatio(
    //     aspectRatio: 16 / 9,
    //     child:
    //  DChartComboO(
    //   groupList: ordinalGroup,
    // );
    //   ),
    // );
  }
}
