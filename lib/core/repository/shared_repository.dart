import 'package:fpdart/fpdart.dart';
import 'package:mood_tracker/core/datasource/mood_local_datasource.dart';
import 'package:mood_tracker/core/error/failure.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';

class SharedRepository {
  final MoodLocalDatasource _moodLocalDatasource;

  SharedRepository({required MoodLocalDatasource moodLocalDatasource})
    : _moodLocalDatasource = moodLocalDatasource;

  Future<Either<Failure, List<MoodsInADay>>> getAllMoodsInADay() async {
    try {
      final allMoodsInADay = await _moodLocalDatasource.getAllMoodsInADay();
      return right(allMoodsInADay);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, MoodsInADay>> getMoodsList({
    required String currentDate,
  }) async {
    try {
      final currentMoodsInADay = await _moodLocalDatasource.getMoodsList(
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
