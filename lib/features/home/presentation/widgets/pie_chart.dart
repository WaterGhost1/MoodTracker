import 'package:flutter/material.dart';
import 'package:mood_tracker/core/theme/app_pallete.dart';
import 'package:pie_chart/pie_chart.dart';

class PChart extends StatelessWidget {
  final Map<String, double> pieData;
  final Map<String, Color> colorMap = {
    "JOY": AppPallete.joy,
    "FEAR": AppPallete.fear,
    "DISGUST": AppPallete.disgust,
    "ANGER": AppPallete.anger,
    "SAD": AppPallete.sad,
  };

  PChart({super.key, required this.pieData});
  final colorsList = [
    AppPallete.joy,
    AppPallete.fear,
    AppPallete.anger,
    AppPallete.disgust,
    AppPallete.joy,
  ];
  @override
  Widget build(BuildContext context) {
    final List<Color> dynamicColors =
        pieData.keys.map((key) {
          return colorMap[key] ?? Colors.grey;
        }).toList();

    return PieChart(
      dataMap: pieData,
      animationDuration: Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: dynamicColors,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      chartLegendSpacing: 50,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
