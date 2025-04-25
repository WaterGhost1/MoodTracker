import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/statistics_model.dart';
import 'package:mood_tracker/features/statistics/presentation/bloc/stat_bloc.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  void initState() {
    context.read<StatBloc>().add(StatDataFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatBloc, StatState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StatisticsModel statModel = state.statisticsModel;
        return Column(
          children: [
            Text("JOY: ${statModel.joyCount}"),
            Text("SAD: ${statModel.sadCount}"),
            Text("FEAR: ${statModel.fearCount}"),
            Text("ANGER: ${statModel.angerCount}"),
            Text("DISGUST: ${statModel.disgustCount}"),
            Text("EMBARASSED: ${statModel.embarassedCount}"),

            Text("================================================"),
            SizedBox(
              height: 300,
              width: 300,
              child: ListView.builder(
                itemCount: state.moodCountInAMonth.keys.length,
                itemBuilder: (context, index) {
                  final date = state.moodCountInAMonth.keys.elementAt(index);
                  final value = state.moodCountInAMonth[date];
                  return ListTile(title: Text(date), subtitle: Text(value!));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
