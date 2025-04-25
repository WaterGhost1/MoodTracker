import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/theme/app_pallete.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/core/utils/picker.dart';
import 'package:mood_tracker/core/widgets/mood_card.dart';
import 'package:mood_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:mood_tracker/core/widgets/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(FetchMoods(date: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.moodsOfTheDay == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset('assets/lottie/nodata.json'),
                ),
                Text("No Data Found..."),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child:
                        state.pieData.isNotEmpty
                            ? PChart(
                              pieData: state.pieData,
                              isRing: true,
                              hasCenter: true,
                              legendRow: true,
                              isLegendBottom: true,
                              isChartValuesOutside: true,
                            )
                            : Text("No moods for today"),
                  ),
                  Text(
                    "WHAT ARE YOU FEELING?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  state.currentMood != null
                      ? GestureDetector(
                        onTap: () {
                          context.goNamed('details', extra: state.currentMood);
                        },
                        child: MoodCard(
                          title: state.currentMood!.name,
                          description: state.currentMood!.description,
                          date: state.moodsOfTheDay!.date,

                          time: DateFormatter.getTime(state.currentMood!.time),
                          moodColor: Picker.colorPicker(
                            name: state.currentMood!.name,
                          ),
                        ),
                      )
                      : SizedBox.shrink(),

                  SizedBox(height: 20),
                  Text(
                    "YOUR MOMENTS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: state.moodsOfTheDay?.moodsList.length ?? 0,
                      itemBuilder: (context, index) {
                        Mood? mood = state.moodsOfTheDay?.moodsList[index];
                        return GestureDetector(
                          onTap: () {
                            context.goNamed('details', extra: mood);
                          },
                          child: MoodCard(
                            title: mood!.name,
                            description: mood.description,
                            date: state.moodsOfTheDay!.date,

                            time: DateFormatter.getTime(mood.time),
                            moodColor: Picker.colorPicker(
                              name: mood.name.toUpperCase(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
