import 'package:fpdart/fpdart.dart';
import 'package:mood_tracker/core/error/failure.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/features/mood_entry/datasource/mood_local_datasource.dart';

class MoodEntryRepository {
  final MoodLocalDatasource moodLocalDatasource;

  MoodEntryRepository({required this.moodLocalDatasource});

  Future<Either<Failure, List<MoodsInADay>>> getAllMoodsInADay() async {
    try {
      final allMoodsInADay = await moodLocalDatasource.getAllMoodsInADay();
      return right(allMoodsInADay);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Mood>> addMood({
    required Mood newMood,
    required DateTime currentDate,
  }) async {
    try {
      final currentMood = await moodLocalDatasource.addMood(
        newMood: newMood,
        currentDate: currentDate,
      );

      return right(currentMood);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, MoodsInADay>> getMoodsList({
    required DateTime currentDate,
  }) async {
    try {
      final currentMoodsInADay = await moodLocalDatasource.getMoodsList(
        currentDate: currentDate,
      );

      if (currentMoodsInADay != null) {
        return right(currentMoodsInADay);
      } else {
        return left(Failure(message: "No Entry Found"));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
