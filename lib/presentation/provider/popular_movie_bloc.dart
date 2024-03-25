import 'dart:async';

import 'package:ditonton/presentation/eventandstate/default_event.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_popular_movies.dart';
import '../eventandstate/movie/event/popular_movie_event.dart';

class PopularMovieBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super((EmptyState())) {
    on<OnPopularMovie>(_onPopularMovie);
  }

  FutureOr<void> _onPopularMovie(OnPopularMovie event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getPopularMovies.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }
}