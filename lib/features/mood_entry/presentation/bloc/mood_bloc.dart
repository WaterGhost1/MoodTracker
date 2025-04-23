import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc() : super(MoodInitial()) {
    on<MoodEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
