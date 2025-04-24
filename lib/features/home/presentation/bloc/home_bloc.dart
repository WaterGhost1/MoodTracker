import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedRepository sharedRepository;
  HomeBloc(this.sharedRepository)
    : super(HomeInitial(currentMood: null, moodsOfTheDay: null)) {
    on<FetchMoods>((event, emit) async {
      final currentMoodVal = await sharedRepository.getMoodsList(
        currentDate: DateFormatter.getDate(event.date),
      );

      currentMoodVal.fold(
        (l) => emit(
          HomeFailed(
            currentMood: state.currentMood,
            moodsOfTheDay: state.moodsOfTheDay,
            message: l.message,
          ),
        ),
        (r) =>
            emit(HomeSucceed(currentMood: r.moodsList.last, moodsOfTheDay: r)),
      );
    });
  }
}
