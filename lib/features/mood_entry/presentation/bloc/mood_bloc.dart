import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/features/mood_entry/repositories/mood_entry_repository.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final MoodEntryRepository moodEntryRepository;
  final SharedRepository sharedRepository;
  MoodBloc({required this.moodEntryRepository, required this.sharedRepository})
    : super(
        MoodInitial(
          currentMood: null,
          currentMoodsInADay: MoodsInADay(
            moodsList: [],
            date: DateFormatter.getDate(DateTime.now()),
          ),
        ),
      ) {
    on<MoodChanged>((event, emit) async {
      final currentMoodVal = await sharedRepository.getMoodsList(
        currentDate: DateFormatter.getDate(event.date),
      );

      currentMoodVal.fold(
        (l) => emit(
          MoodFailed(
            message: l.message,
            currentMood: state.currentMood,
            currentMoodsInADay: state.currentMoodsInADay,
          ),
        ),
        (r) => emit(
          MoodSuccess(currentMood: state.currentMood, currentMoodsInADay: r),
        ),
      );
    });

    on<MoodAdded>((event, emit) async {
      emit(
        MoodLoading(
          currentMood: state.currentMood,
          currentMoodsInADay: state.currentMoodsInADay,
        ),
      );

      final response = await moodEntryRepository.addMood(
        name: event.name,
        time: event.time,
        currentDate: DateFormatter.getDate(event.date),
        description: event.description,
      );

      response.fold(
        (l) => emit(
          MoodFailed(
            message: l.message,
            currentMood: state.currentMood,
            currentMoodsInADay: state.currentMoodsInADay,
          ),
        ),
        (r) {
          emit(
            MoodSuccess(
              currentMood: r,
              currentMoodsInADay: state.currentMoodsInADay,
            ),
          );
          add(MoodChanged(date: event.date));
        },
      );
    });

    on<PageChanged>((event, emit) {
      emit(
        PageChangedState(
          currentMood: state.currentMood,
          currentMoodsInADay: state.currentMoodsInADay,
          moodName: event.moodName,
        ),
      );
    });

    // on<FetchedAllMood>((evemt, emit) async {
    //   final response = await moodEntryRepository.getAllMoodsInADay();

    //   response.fold(
    //     (l) => emit(
    //       MoodFailed(
    //         allMoodsInADay: state.allMoodsInADay,
    //         message: l.message,
    //         currentMood: state.currentMood,
    //         currentMoodsInADay: state.currentMoodsInADay,
    //       ),
    //     ),
    //     (r) => emit(
    //       MoodSuccess(
    //         allMoodsInADay: r,
    //         currentMood: state.currentMood,
    //         currentMoodsInADay: state.currentMoodsInADay,
    //       ),
    //     ),
    //   );
    // });
  }
}
