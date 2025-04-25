import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

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

  static String getHighestMood(Map<String, double> moods) {
    late String highestStr;
    double highestVal = 1;
    moods.forEach((key, value) {
      if (value >= highestVal) {
        highestStr = key;
        highestVal = value;
      } else {
        highestStr = highestStr;
        highestVal = highestVal;
      }
    });
    return highestStr;
  }

  static Map<String, int> getAllMoodsCount({
    required List<MoodsInADay> moodsAll,
  }) {
    Map<String, int> moodCountAll = {};
    for (MoodsInADay moods in moodsAll) {
      List<Mood> moodsListPerDar = moods.moodsList;

      for (Mood mood in moodsListPerDar) {
        if (moodCountAll.containsKey(mood.name)) {
          moodCountAll[mood.name] = moodCountAll[mood.name]! + 1;
        } else {
          moodCountAll[mood.name] = 1;
        }
      }
    }

    return moodCountAll;
  }

  static Map<String, String> getMoodStatsInAMonth({
    required List<MoodsInADay> moodsList,
  }) {
    Map<String, String> moodCountMonth = {};

    for (MoodsInADay moods in moodsList) {
      Map<String, double> moodsCount = countMoodsByName(moods.moodsList);
      moodCountMonth[moods.date] = getHighestMood(moodsCount);
    }

    return moodCountMonth;
  }
}
