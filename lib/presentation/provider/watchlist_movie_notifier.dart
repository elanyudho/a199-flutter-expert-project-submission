import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];

  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistMovieState = RequestState.Empty;

  RequestState get watchlistMovieState => _watchlistMovieState;

  var _watchlistTvSeries = <TvSeries>[];

  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistTvSeriesState = RequestState.Empty;

  RequestState get watchlistTvSeriesState => _watchlistTvSeriesState;

  String _message = '';

  String get message => _message;

  WatchlistMovieNotifier(
      {required this.getWatchlistMovies, required this.getWatchlistTvSeries});

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvSeries getWatchlistTvSeries;

  Future<void> fetchWatchlistMovies() async {
    _watchlistMovieState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistMovieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistMovieState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistTvSeriesState = RequestState.Loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
