import 'package:mood_tracker/core/models/mood_model.dart';

class Calculate {
  static Map<String, double> countMoodsByName(List<Mood> moods) {
    Map<String, double> moodCounts = {};

    for (Mood mood in moods) {
      if (moodCounts.containsKey(mood.name)) {
        moodCounts[mood.name] = moodCounts[mood.name]! + 1;
      } else {
        moodCounts[mood.name] = 1;
      }
    }

    return moodCounts;
  }
}
