import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/core/theme/app_pallete.dart';
import 'package:mood_tracker/features/statistics/model/statistics_model.dart';
import 'package:mood_tracker/core/utils/calculate.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/core/utils/picker.dart';
import 'package:mood_tracker/core/widgets/pie_chart.dart';
import 'package:mood_tracker/features/statistics/presentation/bloc/stat_bloc.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  void initState() {
    context.read<StatBloc>().add(StatDataFetched(currentDate: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatBloc, StatState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StatisticsModel statModel = state.statisticsModel;
        if (state.moodCountInAMonth.isEmpty) {
          return Center(child: Text("No Data Found"));
        } else {
          final moodColor = Picker.colorPicker(
            name: Calculate.getHighestMood(state.moodCountInAMonth).keys.first,
          );
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: moodColor, width: 2),
                      left: BorderSide(color: moodColor, width: 2),
                      right: BorderSide(color: moodColor, width: 4),
                      bottom: BorderSide(color: moodColor, width: 5.0),
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Text("${DateFormatter.getMonth(DateTime.now())} Moods"),
                      PChart(
                        pieData: state.moodCountInAMonth,
                        isRing: false,
                        hasCenter: false,
                        legendRow: false,
                        isLegendBottom: false,
                        isChartValuesOutside: false,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: moodColor, width: 2),
                      left: BorderSide(color: moodColor, width: 2),
                      right: BorderSide(color: moodColor, width: 4),
                      bottom: BorderSide(color: moodColor, width: 5.0),
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You had",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " mood changes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: moodColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              statModel.totalCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            LottieBuilder.asset(
                              'assets/lottie/changes.json',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Highest count container
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: moodColor, width: 2),
                            left: BorderSide(color: moodColor, width: 2),
                            right: BorderSide(color: moodColor, width: 4),
                            bottom: BorderSide(color: moodColor, width: 5.0),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "With the majority",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "count",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: moodColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  //topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  statModel.highest.values.first.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 20),
                    // Highest name container
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: moodColor, width: 2),
                            left: BorderSide(color: moodColor, width: 2),
                            right: BorderSide(color: moodColor, width: 4),
                            bottom: BorderSide(color: moodColor, width: 5.0),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "You mostly",
                                    style: TextStyle(fontSize: 16),
                                  ),

                                  Text(
                                    "experience",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: moodColor,
                                borderRadius: BorderRadius.only(
                                  //topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  statModel.highest.keys.first.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        // return Column(
        //   children: [
        //     //PChart(pieData: state.moodCountInAMonth, isRing: false),
        //     Text("JOY: ${statModel.joyCount}"),
        //     Text("SAD: ${statModel.sadCount}"),
        //     Text("FEAR: ${statModel.fearCount}"),
        //     Text("ANGER: ${statModel.angerCount}"),
        //     Text("DISGUST: ${statModel.disgustCount}"),
        //     Text("EMBARASSED: ${statModel.embarassedCount}"),
        //     Text("================================================"),
        //     SizedBox(
        //       height: 300,
        //       width: 300,
        //       child: ListView.builder(
        //         itemCount: state.moodCountInAMonth.keys.length,
        //         itemBuilder: (context, index) {
        //           final date = state.moodCountInAMonth.keys.elementAt(index);
        //           final value = state.moodCountInAMonth[date];
        //           return ListTile(
        //             title: Text(date),
        //             subtitle: Text(value!.toString()),
        //           );
        //         },
        //       ),
        //     ),
        //     const Text("Mood Chart"),
        //   ],
        // );
      },
    );
  }
}
