import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/repository/shared_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final SharedRepository sharedRepository;
  DetailBloc(this.sharedRepository) : super(DetailInitial(mood: null)) {
    on<MoodFeteched>((event, emit) async {});
  }
}
