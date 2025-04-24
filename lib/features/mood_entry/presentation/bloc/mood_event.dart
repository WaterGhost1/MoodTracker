part of 'mood_bloc.dart';

@immutable
sealed class MoodEvent {}

final class MoodAdded extends MoodEvent {
  final String name;
  final String description;
  final DateTime date;
  final DateTime time;

  MoodAdded({
    required this.name,
    required this.date,
    required this.time,
    required this.description,
  });
}

final class MoodChanged extends MoodEvent {
  final DateTime date;

  MoodChanged({required this.date});
}

final class FetchedAllMood extends MoodEvent {}

final class PageChanged extends MoodEvent {
  final String moodName;

  PageChanged({required this.moodName});
}
