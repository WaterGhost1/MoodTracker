part of 'stat_bloc.dart';

@immutable
sealed class StatEvent {}

final class StatDataFetched extends StatEvent {
  final DateTime currentDate;

  StatDataFetched({required this.currentDate});
}
