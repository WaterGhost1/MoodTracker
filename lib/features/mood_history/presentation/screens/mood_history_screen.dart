import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/routes/app_router.dart';
import 'package:mood_tracker/core/widgets/mood_card.dart';
// import 'package:mood_tracker/colors/color_palette.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('TIMELINE')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'THIS WEEK:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // List View Builder
            MoodCard(
              moodColor: Colors.red,
              title: 'SAD ANG PERSON',
              description:
                  'accidentally nalipat ko yung playlist, tumogtug yung song ng ex ko T- T .... totoy bibo',
              date: 'April 21, 2025',
              time: '5:00pm',
            ),

            IconButton(
              onPressed: () {
                context.go(Routes.homeScreen);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }
}
