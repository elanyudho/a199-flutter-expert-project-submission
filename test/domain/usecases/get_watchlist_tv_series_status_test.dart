import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTvSeriesStatus usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListTvSeriesStatus(mockTvSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToTvSeriesWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
