import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/routes/app_router.dart';

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
          ],
        ),
      ),
    );
  }
}
