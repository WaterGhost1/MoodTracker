part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class FetchMoods extends HomeEvent {
  final DateTime date;
  FetchMoods({required this.date});
}
