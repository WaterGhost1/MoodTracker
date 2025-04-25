import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/core/utils/picker.dart';
import 'package:mood_tracker/core/widgets/mood_card.dart';
import 'package:mood_tracker/features/history/presentation/bloc/history_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(HistoryFetchedAllMoodsInADay());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final groupMoods = state.listOfMoods;
        final keys = state.listOfMoods.keys.toList();
        if (groupMoods.isEmpty) {
          return Center(child: Text("No History Available"));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                final monthYearKey = keys[index];
                final moodsForMonthYear = groupMoods[monthYearKey]!;
                Color cardColor = Colors.white;
                return GestureDetector(
                  // for test only
                  onTap: () {
                    context.goNamed('stat');
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: cardColor, width: 2),
                          left: BorderSide(color: cardColor, width: 2),
                          right: BorderSide(color: cardColor, width: 4),
                          bottom: BorderSide(color: cardColor, width: 5.0),
                        ),
                        borderRadius: BorderRadius.circular(
                          18,
                        ), // Optional: Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                monthYearKey,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),

                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: moodsForMonthYear.length,
                              itemBuilder: (context, index) {
                                final moodDay = moodsForMonthYear[index];
                                return SizedBox(
                                  height: 350,
                                  child: ListView.builder(
                                    itemCount: moodDay.moodsList.length,
                                    itemBuilder: (context, index) {
                                      Mood mood = moodDay.moodsList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          context.goNamed(
                                            'details',
                                            extra: mood,
                                          );
                                        },
                                        child: MoodCard(
                                          title: mood.name,
                                          description: mood.description,
                                          date: moodDay.date,
                                          time: DateFormatter.getTime(
                                            mood.time,
                                          ),
                                          moodColor: Picker.colorPicker(
                                            name: mood.name,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
