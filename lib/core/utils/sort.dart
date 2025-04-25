import 'package:intl/intl.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

class Sort {
  static Map<String, List<MoodsInADay>> groupByDay(
    List<MoodsInADay> moodsList,
  ) {
    Map<String, List<MoodsInADay>> groupedMoods = {};

    for (var moodDay in moodsList) {
      DateTime parsedDate = DateFormat('MMMM dd, yyyy').parse(moodDay.date);

      String dayKey = DateFormat('MMMM dd, yyyy').format(parsedDate);

      if (!groupedMoods.containsKey(dayKey)) {
        groupedMoods[dayKey] = [];
      }

      groupedMoods[dayKey]!.add(moodDay);
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
