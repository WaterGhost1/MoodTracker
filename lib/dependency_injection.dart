import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/models/mood_per_day.dart';
import 'package:mood_tracker/core/datasource/mood_local_datasource.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';
import 'package:mood_tracker/core/routes/cubit/route_cubit.dart';
import 'package:mood_tracker/features/history/presentation/bloc/history_bloc.dart';
import 'package:mood_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:mood_tracker/features/mood_entry/presentation/bloc/mood_bloc.dart';
import 'package:mood_tracker/features/mood_entry/repositories/mood_entry_repository.dart';
import 'package:mood_tracker/features/statistics/presentation/bloc/stat_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //Mood HiveModel Adapter
  Hive.registerAdapter(MoodAdapter());
  Hive.registerAdapter(MoodsInADayAdapter());

  if (!Hive.isBoxOpen('moodDayBox')) {
    await Hive.openBox<MoodsInADay>('moodDayBox');
  }

  //MoodDay Box
  sl.registerLazySingleton<Box<MoodsInADay>>(
    () => Hive.box<MoodsInADay>("moodDayBox"),
  );

  //mood entry dep
  _initMoodEntry();
}

void _initMoodEntry() {
  //MoodLocalDatasource
  sl.registerLazySingleton<MoodLocalDatasource>(
    () => MoodLocalDatasource(moodDayBox: sl<Box<MoodsInADay>>()),
  );

  //SharedRepository
  sl.registerFactory<SharedRepository>(
    () => SharedRepository(moodLocalDatasource: sl<MoodLocalDatasource>()),
  );

  //MoodEntryRepository
  sl.registerFactory<MoodEntryRepository>(
    () => MoodEntryRepository(moodLocalDatasource: sl<MoodLocalDatasource>()),
  );

  // Nav Cubit
  sl.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());

  // MoodBloc
  sl.registerFactory<MoodBloc>(
    () => MoodBloc(
      moodEntryRepository: sl<MoodEntryRepository>(),
      sharedRepository: sl<SharedRepository>(),
    ),
  );

  // HomeBloc
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(sharedRepository: sl<SharedRepository>()),
  );

  // History Bloc
  sl.registerFactory<HistoryBloc>(
    () => HistoryBloc(sharedRepository: sl<SharedRepository>()),
  );

  // Stat Bloc
  sl.registerFactory<StatBloc>(
    () => StatBloc(sharedRepository: sl<SharedRepository>()),
  );
}
