part of 'stat_bloc.dart';

@immutable
sealed class StatState {
  final StatisticsModel statisticsModel;
  final Map<String, double> moodCountInAMonth;
  const StatState({
    required this.moodCountInAMonth,
    required this.statisticsModel,
  });
}

final class StatInitial extends StatState {
  const StatInitial({
    required super.moodCountInAMonth,
    required super.statisticsModel,
  });
}

final class StatSuccess extends StatState {
  const StatSuccess({
    required super.moodCountInAMonth,
    required super.statisticsModel,
  });
}

final class StatFailed extends StatState {
  final String message;
  const StatFailed({
    required super.moodCountInAMonth,
    required this.message,
    required super.statisticsModel,
  });
}

final class StatLoading extends StatState {
  const StatLoading({
    required super.moodCountInAMonth,
    required super.statisticsModel,
  });
}
