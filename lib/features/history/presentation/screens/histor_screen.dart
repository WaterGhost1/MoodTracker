import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/features/history/presentation/bloc/history_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch data using the bloc
    context.read<HistoryBloc>().add(HistoryFetchedAllMoodsInADay());

    return Scaffold(
      appBar: AppBar(title: Text('Grouped Moods')),
      body: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Failed to fetch moods')));
          }
        },
        builder: (context, state) {
          if (state is HistoryInitial || state is HistoryFailed) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HistorySuccess) {
            final groupedMoods = state.listOfMoods;

            return ListView(
              children:
                  groupedMoods.entries.map((entry) {
                    final monthYear = entry.key;
                    final moods = entry.value;

                    return ExpansionTile(
                      title: Text(
                        monthYear,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      children:
                          moods.map((mood) {
                            return ListTile(
                              title: Text(mood.),
                              subtitle: Text(mood.date.toString()),
                            );
                          }).toList(),
                    );
                  }).toList(),
            );
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
