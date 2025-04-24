import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/theme/app_pallete.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/core/utils/picker.dart';
import 'package:mood_tracker/core/widgets/mood_card.dart';
import 'package:mood_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:mood_tracker/features/home/presentation/widgets/pie_chart.dart';

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
          return Center(child: Text("No Data Found"));
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child:
                        state.pieData.isNotEmpty
                            ? PChart(pieData: state.pieData)
                            : Text("No moods for today"),
                  ),
                  Text("Current"),
                  state.currentMood != null
                      ? MoodCard(
                        title: state.currentMood!.name,
                        description: state.currentMood!.description,
                        date: state.moodsOfTheDay!.date,
                        time: DateFormatter.getTime(state.currentMood!.time),
                        moodColor: Picker.colorPicker(
                          name: state.currentMood!.name,
                        ),
                      )
                      : SizedBox.shrink(),
                  Text("History"),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: state.moodsOfTheDay?.moodsList.length ?? 0,
                      itemBuilder: (context, index) {
                        Mood? mood = state.moodsOfTheDay?.moodsList[index];
                        return MoodCard(
                          title: mood!.name,
                          description: mood.description,
                          date: state.moodsOfTheDay!.date,
                          time: DateFormatter.getTime(mood.time),
                          moodColor: Picker.colorPicker(
                            name: mood.name.toUpperCase(),
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
