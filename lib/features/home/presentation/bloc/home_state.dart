part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final Mood? currentMood;
  final MoodsInADay? moodsOfTheDay;
  final Map<String, double> pieData;

  const HomeState({
    required this.pieData,
    required this.currentMood,
    required this.moodsOfTheDay,
  });
}

final class HomeInitial extends HomeState {
  const HomeInitial({
    required super.currentMood,
    required super.moodsOfTheDay,
    required super.pieData,
  });
}

final class HomeSucceed extends HomeState {
  const HomeSucceed({
    required super.currentMood,
    required super.moodsOfTheDay,
    required super.pieData,
  });
}

final class HomeFailed extends HomeState {
  final String message;
  const HomeFailed({
    required this.message,
    required super.currentMood,
    required super.moodsOfTheDay,
    required super.pieData,
  });
}

final class HomeLoading extends HomeState {
  const HomeLoading({
    required super.currentMood,
    required super.moodsOfTheDay,
    required super.pieData,
  });
}
