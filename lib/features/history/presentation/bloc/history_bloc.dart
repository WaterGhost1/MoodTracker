import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';
import 'package:mood_tracker/core/utils/sort.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final SharedRepository sharedRepository;
  HistoryBloc({required this.sharedRepository})
    : super(HistoryInitial(listOfMoods: {})) {
    on<HistoryFetchedAllMoodsInADay>((event, emit) async {
      final response = await sharedRepository.getAllMoodsInADay();

      response.fold(
        (l) => emit(HistoryFailed(listOfMoods: state.listOfMoods)),
        (r) {
          final sortedListOfMoods = Sort.groupByMonthYear(r);
          emit(HistorySuccess(listOfMoods: sortedListOfMoods));
        },
      );
    });
  }
}
