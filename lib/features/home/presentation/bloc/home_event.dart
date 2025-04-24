part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class FetchMoods extends HomeEvent {
  final DateTime date;
  final Mood currentMood;
  FetchMoods({required this.currentMood, required this.date});
}
