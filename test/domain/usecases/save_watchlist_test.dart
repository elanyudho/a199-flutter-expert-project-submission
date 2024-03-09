import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveMovieWatchlist usecaseMovie;
  late SaveTvSeriesWatchlist usecaseTvSeries;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseMovie = SaveMovieWatchlist(mockMovieRepository);
    usecaseTvSeries = SaveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecaseMovie.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlistMovie(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveTvSeriesWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecaseTvSeries.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.saveTvSeriesWatchlist(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
