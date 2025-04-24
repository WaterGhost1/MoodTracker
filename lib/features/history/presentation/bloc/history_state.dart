part of 'history_bloc.dart';

@immutable
sealed class HistoryState {
  final Map<String, List<MoodsInADay>> listOfMoods;

  const HistoryState({required this.listOfMoods});
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial({required super.listOfMoods});
}

final class HistorySuccess extends HistoryState {
  const HistorySuccess({required super.listOfMoods});
}

final class HistoryFailed extends HistoryState {
  const HistoryFailed({required super.listOfMoods});
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading({required super.listOfMoods});
}
