import 'package:hive/hive.dart';
import 'package:mood_tracker/core/models/mood_model.dart';

part 'mood_per_day.g.dart';

@HiveType(typeId: 0)
class MoodsInADay {
  @HiveField(0)
  final List<Mood> moodsList;
  @HiveField(1)
  final String date;

  MoodsInADay({required this.moodsList, required this.date});
}
