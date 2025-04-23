import 'package:mood_tracker/core/models/journal_model.dart';
import 'package:mood_tracker/core/models/mood_model.dart';

class MoodsInADay {
  final List<Mood> moodsList;
  final Journal journal;
  final DateTime date;

  MoodsInADay({
    required this.moodsList,
    required this.date,
    required this.journal,
  });
}
