part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent {}

final class MoodFeteched extends DetailEvent {
  final String id;

  MoodFeteched({required this.id});
}
