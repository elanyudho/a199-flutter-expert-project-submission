import 'dart:async';

import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/eventandstate/default_event.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/remove_watchlist_movie.dart';
import '../../domain/usecases/save_watchlist_movie.dart';
import '../eventandstate/movie/event/remove_watch_list_movie_event.dart';
import '../eventandstate/movie/event/save_watch_list_movie_event.dart';
import '../eventandstate/movie/event/watchlist_movie_status_event.dart';
import '../eventandstate/movie/event/watchlist_movies_event.dart';

class WatchListMovieBloc extends Bloc<DefaultEvent, DefaultState> {

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListMovieStatus _getWatchListMovieStatus;
  final SaveMovieWatchlist _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  WatchListMovieBloc(this._getWatchlistMovies, this._getWatchListMovieStatus, this._saveWatchlistMovie, this._removeWatchlistMovie) : super((EmptyState())) {
    on<OnWatchListMovies>(_onWatchListMovies);
    on<OnWatchListMovieStatus>(_onWatchListMovieStatus);
    on<OnSaveWatchListMovie>(_onSaveWatchListMovie);
    on<OnRemoveWatchListMovie>(_onRemoveWatchlistMovie);
  }

  FutureOr<void> _onWatchListMovies(OnWatchListMovies event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }

  FutureOr<void> _onWatchListMovieStatus(OnWatchListMovieStatus event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getWatchListMovieStatus.execute(event.id);
    emit(HasBoolDataState(result));

  }

  FutureOr<void> _onSaveWatchListMovie(OnSaveWatchListMovie event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _saveWatchlistMovie.execute(event.movieDetail);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasMessageDataState(data));
    });
  }

  FutureOr<void> _onRemoveWatchlistMovie(OnRemoveWatchListMovie event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _removeWatchlistMovie.execute(event.movieDetail);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasMessageDataState(data));
    });
  }
}