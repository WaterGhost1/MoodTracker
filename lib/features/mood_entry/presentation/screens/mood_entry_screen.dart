import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/features/mood_entry/presentation/bloc/mood_bloc.dart';

class MoodEntryScreen extends StatefulWidget {
  const MoodEntryScreen({super.key});

  @override
  State<MoodEntryScreen> createState() => _MoodEntryScreenState();
}

class _MoodEntryScreenState extends State<MoodEntryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodBloc, MoodState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(label: Text("Emotion")),
            ),
            TextFormField(
              controller: descController,
              decoration: InputDecoration(label: Text("Journal")),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<MoodBloc>().add(
                  MoodAdded(
                    name: nameController.text,
                    date: DateTime.now(),
                    time: DateTime.now(),
                    description: descController.text,
                  ),
                );
              },
              child: Text("Add"),
            ),

            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: state.currentMoodsInADay?.moodsList.length,
                itemBuilder: (context, index) {
                  Mood? mood = state.currentMoodsInADay?.moodsList[index];

                  if (state.currentMoodsInADay!.moodsList.isEmpty) {
                    return (Text("No data"));
                  } else {
                    return ListTile(title: Text(mood!.name));
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
