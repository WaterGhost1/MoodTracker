import 'package:flutter/material.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/utils/picker.dart';

class DetailScreen extends StatelessWidget {
  final Mood mood;
  const DetailScreen({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    final String? imgPath =
        Picker.imgPicker(name: mood.name) ?? 'assets/imagesnoBg/anger.png';
    return Column(
      children: [
        Image.asset(imgPath!),
        Text("Mood: ${mood.name}"),
        Text("Why?"),
        Text(mood.description ?? "Idk"),
      ],
    );
  }
}
