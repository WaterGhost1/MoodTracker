part of 'detail_bloc.dart';

@immutable
sealed class DetailState {
  final Mood? mood;

  const DetailState({required this.mood});
}

final class DetailInitial extends DetailState {
  const DetailInitial({required super.mood});
}

final class DetailSuccess extends DetailState {
  const DetailSuccess({required super.mood});
}

final class DetailFailed extends DetailState {
  const DetailFailed({required super.mood});
}

final class DetailLoading extends DetailState {
  const DetailLoading({required super.mood});
}
