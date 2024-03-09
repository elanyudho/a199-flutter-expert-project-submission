import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies usecaseMovie;
  late SearchTvSeries usecaseTvSeries;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseMovie = SearchMovies(mockMovieRepository);
    usecaseTvSeries = SearchTvSeries(mockTvSeriesRepository);
  });

  final tMovies = <Movie>[];
  final tQuery = 'Spiderman';

  final tvSeries = <TvSeries>[];
  final tvSeriesQuery = 'Game';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecaseMovie.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });

  test('should get list of tvSeries from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tvSeriesQuery))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecaseTvSeries.execute(tvSeriesQuery);
    // assert
    expect(result, Right(tvSeries));
  });
}
