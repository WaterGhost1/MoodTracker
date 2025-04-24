import 'package:intl/intl.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

class Sort {
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
}
