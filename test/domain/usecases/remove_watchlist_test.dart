import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecaseMovie;
  late RemoveWatchlistTvSeries usecaseTvSeries;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseMovie = RemoveWatchlistMovie(mockMovieRepository);
    usecaseTvSeries = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecaseMovie.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlistMovie(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecaseTvSeries.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
