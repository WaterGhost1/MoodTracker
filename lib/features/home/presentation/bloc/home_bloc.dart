import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';
import 'package:mood_tracker/core/utils/calculate.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/core/utils/sort.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedRepository sharedRepository;
  HomeBloc({required this.sharedRepository})
    : super(HomeInitial(currentMood: null, moodsOfTheDay: null, pieData: {})) {
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
            pieData: state.pieData,
          ),
        ),
        (r) {
          final List<Mood> moodsList = r.moodsList;

          final Map<String, double> dataMap;

          if (moodsList.isEmpty) {
            dataMap = {};
          } else {
            dataMap = Calculate.countMoodsByName(moodsList);
          }
          //print("Data Map: $dataMap");
          final MoodsInADay sortedMoods = MoodsInADay(
            moodsList: Sort.sortAndReturnNewListWithoutLatest(r.moodsList),
            date: r.date,
          );
          emit(
            HomeSucceed(
              currentMood: r.moodsList.last,
              moodsOfTheDay: sortedMoods,
              pieData: dataMap,
            ),
          );
        },
      );
    });

    on<FetchMoodById>((event, emit) {
      emit(
        HomeIndividualMood(
          pieData: state.pieData,
          currentMood: state.currentMood,
          moodsOfTheDay: state.moodsOfTheDay,
          mood: event.mood,
        ),
      );
    });
  }
}
