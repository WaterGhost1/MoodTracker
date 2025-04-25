import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/core/theme/app_pallete.dart';
import 'package:mood_tracker/core/utils/calculate.dart';
import 'package:mood_tracker/core/utils/picker.dart';
import 'package:pie_chart/pie_chart.dart';

class PChart extends StatelessWidget {
  final bool hasCenter;
  final bool legendRow;
  final bool isChartValuesOutside;
  final bool isLegendBottom;
  final bool isRing;
  final Map<String, double> pieData;
  final Map<String, Color> colorMap = {
    "JOY": AppPallete.joy,
    "FEAR": AppPallete.fear,
    "DISGUST": AppPallete.disgust,
    "ANGER": AppPallete.anger,
    "SAD": AppPallete.sad,
    "EMBARASSMENT": AppPallete.embarass,
  };

  PChart({
    super.key,
    required this.pieData,
    required this.isRing,
    required this.hasCenter,
    required this.legendRow,
    required this.isLegendBottom,
    required this.isChartValuesOutside,
  });
  final colorsList = [
    AppPallete.joy,
    AppPallete.fear,
    AppPallete.anger,
    AppPallete.disgust,
    AppPallete.joy,
  ];

  @override
  Widget build(BuildContext context) {
    final String? lottiePath = Picker.lottiePicker(
      name: Calculate.getHighestMood(pieData).keys.first,
    );
    final List<Color> dynamicColors =
        pieData.keys.map((key) {
          return colorMap[key] ?? Colors.grey;
        }).toList();

    return PieChart(
      dataMap: pieData,
      animationDuration: Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width / 3,
      colorList: dynamicColors,
      initialAngleInDegree: 0,
      chartType: isRing ? ChartType.ring : ChartType.disc,
      chartLegendSpacing: 50,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: legendRow,
        legendPosition:
            isLegendBottom ? LegendPosition.bottom : LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerWidget:
          hasCenter
              ? SizedBox(
                height: 90,
                width: 100,
                child: Lottie.asset(lottiePath!, width: 80, height: 80),
              )
              : SizedBox.shrink(),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: isChartValuesOutside,
        decimalPlaces: 0,
      ),
    );
  }
}
