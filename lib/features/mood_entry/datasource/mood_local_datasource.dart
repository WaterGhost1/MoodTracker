import 'package:hive/hive.dart';
import 'package:mood_tracker/core/models/journal_model.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:uuid/uuid.dart';

class MoodLocalDatasource {
  final Box moodDayBox;

  MoodLocalDatasource({required this.moodDayBox});

  Future<List<MoodsInADay>> getAllMoodsInADay() async {
    final response = moodDayBox.values;
    return response.cast<MoodsInADay>().toList();
  }

  Future<MoodsInADay?> getMoodsList({required DateTime currentDate}) async {
    return await moodDayBox.get(currentDate);
  }

  //wont be implemented in repo
  Future<MoodsInADay> createNewMoodsList({
    required DateTime currentDate,
    required Mood currentMood,
  }) async {
    final List<Mood> newMoodsList = [currentMood];
    final Journal blankJournal = Journal(
      id: Uuid().v4(),
      title: "",
      content: "",
    );
    final MoodsInADay newMoodsRecord = MoodsInADay(
      moodsList: newMoodsList,
      date: currentDate,
      journal: blankJournal,
    );
    await moodDayBox.put(currentDate, newMoodsRecord);
    return newMoodsRecord;
  }

  Future<Mood> addMood({
    required Mood newMood,
    required DateTime currentDate,
  }) async {
    final currentMoodList = await getMoodsList(currentDate: currentDate);

    if (currentMoodList != null) {
      currentMoodList.moodsList.add(newMood);
      await moodDayBox.put(currentDate, currentMoodList);
    } else {
      await createNewMoodsList(currentDate: currentDate, currentMood: newMood);
    }
    return newMood;
  }
}
