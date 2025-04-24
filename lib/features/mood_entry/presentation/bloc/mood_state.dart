part of 'mood_bloc.dart';

@immutable
sealed class MoodState {
  final Mood? currentMood;
  final MoodsInADay? currentMoodsInADay;

  const MoodState({
    required this.currentMood,
    required this.currentMoodsInADay,
  });
}

final class MoodInitial extends MoodState {
  const MoodInitial({
    required super.currentMood,
    required super.currentMoodsInADay,
  });
}

final class MoodSuccess extends MoodState {
  const MoodSuccess({
    required super.currentMood,
    required super.currentMoodsInADay,
  });
}

final class MoodFailed extends MoodState {
  final String message;
  const MoodFailed({
    required this.message,
    required super.currentMood,
    required super.currentMoodsInADay,
  });
}

final class MoodLoading extends MoodState {
  const MoodLoading({
    required super.currentMood,
    required super.currentMoodsInADay,
  });
}

final class PageChangedState extends MoodState {
  final String moodName;

  const PageChangedState({
    required super.currentMood,
    required super.currentMoodsInADay,
    required this.moodName,
  });
}
