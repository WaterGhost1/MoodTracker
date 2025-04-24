import 'package:fpdart/fpdart.dart';
import 'package:mood_tracker/core/error/failure.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/datasource/mood_local_datasource.dart';

import 'package:uuid/uuid.dart';

class MoodEntryRepository {
  final MoodLocalDatasource _moodLocalDatasource;

  MoodEntryRepository({required MoodLocalDatasource moodLocalDatasource})
    : _moodLocalDatasource = moodLocalDatasource;

  Future<Either<Failure, Mood>> addMood({
    required String name,
    required String description,
    required DateTime time,
    required String currentDate,
  }) async {
    try {
      final newMood = Mood(
        id: Uuid().v4(),
        name: name,
        time: time,
        description: description,
      );

      final currentMood = await _moodLocalDatasource.addMood(
        newMood: newMood,
        currentDate: currentDate,
      );

      return right(currentMood);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
