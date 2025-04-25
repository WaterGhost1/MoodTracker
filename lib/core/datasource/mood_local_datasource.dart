import 'package:hive/hive.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

class MoodLocalDatasource {
  final Box moodDayBox;
  MoodLocalDatasource({required this.moodDayBox});

  Future<List<MoodsInADay>> getAllMoodsInADay() async {
    final response = moodDayBox.values;
    return response.cast<MoodsInADay>().toList();
  }

  Future<MoodsInADay?> getMoodsList({required String currentDate}) async {
    return await moodDayBox.get(currentDate);
  }

  //wont be implemented in repo
  Future<MoodsInADay> createNewMoodsList({
    required String currentDate,
    required Mood currentMood,
  }) async {
    final List<Mood> newMoodsList = [currentMood];

    final MoodsInADay newMoodsRecord = MoodsInADay(
      moodsList: newMoodsList,
      date: currentDate,
    );
    await moodDayBox.put(currentDate, newMoodsRecord);
    return newMoodsRecord;
  }

  Future<Mood> addMood({
    required Mood newMood,
    required String currentDate,
  }) async {
    MoodsInADay? currentMoodsInADay = await getMoodsList(
      currentDate: currentDate,
    );

    if (currentMoodsInADay != null) {
      List<Mood> newMoodsList = List.from(currentMoodsInADay.moodsList);
      newMoodsList.add(newMood);

      MoodsInADay updatedMoodsInADay = MoodsInADay(
        moodsList: newMoodsList,
        date: currentMoodsInADay.date,
      );

      await moodDayBox.put(currentDate, updatedMoodsInADay);
    } else {
      await createNewMoodsList(currentDate: currentDate, currentMood: newMood);
    }

    return newMood;
  }

  Future<List> getMoodsListInAMonth({required String month}) async {
    final List filteredMoods =
        moodDayBox.values.where((mood) {
          return mood.date == month;
        }).toList();

    return filteredMoods;
  }
}
