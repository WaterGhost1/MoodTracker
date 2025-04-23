import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/routes/app_router.dart';

class MoodEntryScreen extends StatelessWidget {
  const MoodEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.go(Routes.homeScreen);
        },
        child: Text('click'),
      ),
    );
  }
}
