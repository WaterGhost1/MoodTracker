import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

import 'package:mood_tracker/core/routes/param_models/detail_param.dart';
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
      listener: (context, state) {},
      builder: (context, state) {
        final groupMoods = state.listOfMoods;
        final keys = state.listOfMoods.keys.toList();

        if (groupMoods.isEmpty) {
          return Center(child: Text("No History Available"));
        } else {
          final monthYearKey = keys[0];
          final moodsForMonthYear = groupMoods[monthYearKey]!;

          final flattenMood =
              moodsForMonthYear.expand((moodDay) {
                return moodDay.moodsList.map(
                  (mood) => {'date': moodDay.date, 'mood': mood},
                );
              }).toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                toolbarHeight: 20,

                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/images2/logowithtxt.png',

                    width: 100,
                  ),
                ),
              ),
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                title: Text(
                  'TIMELINE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: _CustomHeaderDelegate(
                  maxHeight: 50,
                  minHeight: 1,
                  child: Text(monthYearKey),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index >= flattenMood.length) return SizedBox.shrink();
                  final moodEntry = flattenMood[index];
                  final Mood mood = moodEntry['mood'] as Mood;
                  final String date = moodEntry['date'] as String;

                  return GestureDetector(
                    onTap: () {
                      DetailParam detailParam = DetailParam(
                        date: date.toString(),
                        mood: mood,
                      );
                      context.goNamed('details', extra: detailParam);
                    },
                    child: MoodCard(
                      title: mood.name,
                      description: mood.description,
                      date: date.toString(),
                      time: DateFormatter.getTime(mood.time),
                      moodColor: Picker.colorPicker(name: mood.name),
                    ),
                  );
                }, childCount: flattenMood.length),
              ),

              // SliverFillRemaining(),
            ],
          );
        }
      },
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  _CustomHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.blue, child: Center(child: child));
  }

  @override
  double get maxExtent => maxHeight; // Maximum expanded height

  @override
  double get minExtent => minHeight; // Minimum collapsed height

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
