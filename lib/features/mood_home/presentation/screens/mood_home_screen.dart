import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/routes/app_router.dart';
import 'package:mood_tracker/core/widgets/mood_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen'),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.entryScreen);
              },
              child: Text('go to add new screen'),
            ),
            MoodCard(
              moodColor: Colors.red,
              title: 'SELF EVICTION',
              description: 'masaya nga ako bakit ba, nginitian ako eh',
              date: 'April 23, 2024',
              time: '4:19pm',
            ),

            ElevatedButton(
              onPressed: () {
                context.go(Routes.historyScreen);
              },
              child: Text('go to history'),
            ),
          ],
        ),
      ),
    );
  }
}







// stats: pie chart
//current mood: Card[icon, journal]
// history: ListTile
//buttons: [add]


//emotions: happy, sad, angry, scared, surprised