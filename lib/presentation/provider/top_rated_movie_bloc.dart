import 'dart:async';

import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/eventandstate/default_event.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/top_rated_movie_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TopRatedMovieBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super((EmptyState())) {
    on<OnTopRatedMovie>(_onTopRatedMovie);
  }

  FutureOr<void> _onTopRatedMovie(OnTopRatedMovie event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getTopRatedMovies.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }
}