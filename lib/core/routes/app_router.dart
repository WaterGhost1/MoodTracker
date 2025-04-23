import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/mood_entry/presentation/screens/mood_entry_screen.dart';
import 'package:mood_tracker/features/mood_home/presentation/screens/mood_home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.entryScreen,
      builder: (context, state) => MoodEntryScreen(),
    ),

    GoRoute(path: Routes.homeScreen, builder: (context, state) => HomeScreen()),
  ],
);

class Routes {
  static const String entryScreen = '/';
  static const String homeScreen = '/homeScreen';
}
