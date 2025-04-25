import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/routes/cubit/route_cubit.dart';
import 'package:mood_tracker/core/theme/app_pallete.dart';
import 'package:mood_tracker/features/history/presentation/screens/history_screen.dart';
import 'package:mood_tracker/features/home/presentation/screens/home_page.dart';
import 'package:mood_tracker/features/mood_details/presentation/screens/detail_screen.dart';
import 'package:mood_tracker/features/mood_entry/presentation/screens/mood_entry_screen.dart';
import 'package:mood_tracker/features/statistics/presentation/screens/stat_screen.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              appBar: AppBar(),
              body: child,
              bottomNavigationBar: BlocBuilder<BottomNavigationCubit, int>(
                builder: (context, activeIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                    child: BottomAppBar(
                      shape: const CircularNotchedRectangle(),
                      notchMargin: 8.0,
                      //color: Colors.amberAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<BottomNavigationCubit>()
                                    .updateTabIndex(0);
                                context.goNamed('home');
                              },
                              child: Container(
                                color:
                                    activeIndex == 0
                                        ? AppPallete.joy
                                        : Colors.transparent,
                                height: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.home,
                                    color:
                                        activeIndex == 0
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<BottomNavigationCubit>()
                                    .updateTabIndex(1);
                                context.goNamed('entry');
                              },
                              child: Container(
                                color:
                                    activeIndex == 1
                                        ? AppPallete.joy
                                        : Colors.transparent,
                                height: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color:
                                        activeIndex == 1
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<BottomNavigationCubit>()
                                    .updateTabIndex(2);
                                context.goNamed('history');
                              },
                              child: Container(
                                color:
                                    activeIndex == 2
                                        ? AppPallete.joy
                                        : Colors.transparent,
                                height: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.history,
                                    color:
                                        activeIndex == 2
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/history',
              name: 'history',
              builder: (context, state) => const HistoryScreen(),
            ),
            GoRoute(
              path: '/entry',
              name: 'entry',
              builder: (context, state) => const AddNewEntry(),
            ),
            GoRoute(
              path: '/stat',
              name: 'stat',
              builder: (context, state) => const StatScreen(),
            ),
            GoRoute(
              path: '/details',
              name: 'details',
              builder: (context, state) {
                final mood = state.extra as Mood;
                return DetailScreen(mood: mood);
              },
            ),
          ],
        ),
      ],
    );
  }
}
