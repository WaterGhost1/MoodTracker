import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/features/statistics/model/statistics_model.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';
import 'package:mood_tracker/core/utils/calculate.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';

part 'stat_event.dart';
part 'stat_state.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  final SharedRepository sharedRepository;
  StatBloc({required this.sharedRepository})
    : super(
        StatInitial(
          statisticsModel: StatisticsModel(
            joyCount: 0,
            angerCount: 0,
            sadCount: 0,
            fearCount: 0,
            disgustCount: 0,
            embarassedCount: 0,
          ),
          moodCountInAMonth: {},
        ),
      ) {
    on<StatDataFetched>((event, emit) async {
      final response = await sharedRepository.getAllMoodsInADay();

      response.fold(
        (l) => emit(
          StatFailed(
            message: l.message,
            statisticsModel: state.statisticsModel,
            moodCountInAMonth: state.moodCountInAMonth,
          ),
        ),
        (r) {
          final Map<String, double> statData = Calculate.getAllMoodsCount(
            moodsAll: r,
          );

          final List<MoodsInADay> moodsInADayForTheMonth =
              Calculate.getMoodStatsInAMonthAndYear(
                moodsList: r,
                month: DateFormatter.getMonth(event.currentDate),
                year: DateFormatter.getYear(event.currentDate),
              );

          final StatisticsModel stat = StatisticsModel(
            joyCount: statData['JOY'] ?? 0,
            angerCount: statData['ANGER'] ?? 0,
            sadCount: statData['SAD'] ?? 0,
            fearCount: statData['FEAR'] ?? 0,
            disgustCount: statData['DISGUST'] ?? 0,
            embarassedCount: statData['EMBARASSMENT'] ?? 0,
          );
          print(
            "month: ${DateFormatter.getMonth(event.currentDate)} result ${Calculate.getAllMoodsCount(moodsAll: moodsInADayForTheMonth)}",
          );
          emit(
            StatSuccess(
              statisticsModel: stat,
              moodCountInAMonth: Calculate.getAllMoodsCount(
                moodsAll: moodsInADayForTheMonth,
              ),
            ),
          );
        },
      );
    });
  }
}
