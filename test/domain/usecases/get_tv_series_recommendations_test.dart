import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  final tId = 1;
  final tvSeries = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.getRecommendationTvSeries(tId))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tvSeries));
  });
}
