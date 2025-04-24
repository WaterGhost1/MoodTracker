import 'package:fpdart/fpdart.dart';
import 'package:mood_tracker/core/datasource/mood_local_datasource.dart';
import 'package:mood_tracker/core/error/failure.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

class HistoryRepository {
  final MoodLocalDatasource _moodLocalDatasource;

  HistoryRepository({required MoodLocalDatasource moodLocalDatasource})
    : _moodLocalDatasource = moodLocalDatasource;

  Future<Either<Failure, List<MoodsInADay>>> getAllMoodsInADay() async {
    try {
      final allMoodsInADay = await _moodLocalDatasource.getAllMoodsInADay();
      return right(allMoodsInADay);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
