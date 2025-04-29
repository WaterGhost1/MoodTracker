import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        final monthYearKey = keys[0];
        final moodsForMonthYear = groupMoods[monthYearKey]!;

        if (groupMoods.isEmpty) {
          return Center(child: Text("No History Available"));
        } else {
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
              SliverFixedExtentList(
                itemExtent: 100,
                delegate: SliverChildBuilderDelegate((context, index) {
                  final moodDay = moodsForMonthYear[index];
                  return Column(
                    children:
                        moodDay.moodsList.map((mood) {
                          return GestureDetector(
                            onTap: () {
                              DetailParam detailParam = DetailParam(
                                date: moodDay.date,
                                mood: mood,
                              );
                              context.goNamed('details', extra: detailParam);
                            },
                            child: MoodCard(
                              title: mood.name,
                              description: mood.description,
                              date: moodDay.date,
                              time: DateFormatter.getTime(mood.time),
                              moodColor: Picker.colorPicker(name: mood.name),
                            ),
                          );
                        }).toList(),
                  );
                }),
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
