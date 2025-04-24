import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/routes/app_router.dart';
import 'package:mood_tracker/core/routes/cubit/route_cubit.dart';
import 'package:mood_tracker/dependency_injection.dart';
import 'package:mood_tracker/features/home/presentation/bloc/home_bloc.dart';

import 'package:mood_tracker/features/mood_entry/presentation/bloc/mood_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  final appRouter = AppRouter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BottomNavigationCubit>()),
        BlocProvider(create: (_) => sl<MoodBloc>()),
        BlocProvider(create: (_) => sl<HomeBloc>()),
      ],
      child: MaterialApp.router(routerConfig: appRouter.router),
    ),
  );
}
