part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final Mood? currentMood;
  final MoodsInADay? moodsOfTheDay;

  const HomeState({required this.currentMood, required this.moodsOfTheDay});
}

final class HomeInitial extends HomeState {
  const HomeInitial({required super.currentMood, required super.moodsOfTheDay});
}

final class HomeSucceed extends HomeState {
  const HomeSucceed({required super.currentMood, required super.moodsOfTheDay});
}

final class HomeFailed extends HomeState {
  final String message;
  const HomeFailed({
    required this.message,
    required super.currentMood,
    required super.moodsOfTheDay,
  });
}

final class HomeLoading extends HomeState {
  const HomeLoading({required super.currentMood, required super.moodsOfTheDay});
}
