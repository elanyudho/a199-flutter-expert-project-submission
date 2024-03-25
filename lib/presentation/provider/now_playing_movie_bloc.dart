import 'dart:async';

import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/default_event.dart';
import '../eventandstate/default_state.dart';
import '../eventandstate/movie/event/now_playing_movie_event.dart';

class NowPlayingMovieBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies) : super((EmptyState())) {
    on<OnNowPlayingMovie>(_onNowPlayingMovie);
  }

  FutureOr<void> _onNowPlayingMovie(OnNowPlayingMovie event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }
}