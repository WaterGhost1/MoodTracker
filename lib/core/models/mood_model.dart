import 'package:hive/hive.dart';
part 'mood_model.g.dart';

@HiveType(typeId: 1)
class Mood {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final String? description;

  Mood({
    required this.id,
    required this.name,
    required this.time,
    required this.description,
  });
}
