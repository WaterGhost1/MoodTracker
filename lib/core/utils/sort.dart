import 'package:intl/intl.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

class Sort {
  static List<MoodsInADay> sortMoodsByDateDescending(
    List<MoodsInADay> moodsList,
  ) {
    moodsList.sort((a, b) {
      final dateA = DateTime.parse(a.date);
      final dateB = DateTime.parse(b.date);
      return dateB.compareTo(dateA);
    });
    return moodsList;
  }

  static Map<String, List<MoodsInADay>> groupByMonthYear(
    List<MoodsInADay> moodsList,
  ) {
    Map<String, List<MoodsInADay>> groupedMoods = {};

    for (var moodDay in moodsList) {
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(moodDay.date);

      String monthYearKey =
          "${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}";

      if (!groupedMoods.containsKey(monthYearKey)) {
        groupedMoods[monthYearKey] = [];
      }

      groupedMoods[monthYearKey]!.add(moodDay);
    }

    return groupedMoods;
  }

  static List<Mood> sortAndReturnNewListWithoutLatest(List<Mood> moodList) {
    List<Mood> newList = List.from(moodList);

    newList.sort((a, b) => b.time.compareTo(a.time));

    if (newList.isNotEmpty) {
      newList.removeAt(0);
    }

    return newList;
  }
}
