import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRpository;

  setUp(() {
    mockTvSeriesRpository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRpository);
  });

  final tvSeries = <TvSeries>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRpository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tvSeries));
      });
    });
  });
}
