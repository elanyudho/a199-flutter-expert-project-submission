import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/remove_watch_list_tv_series_event.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/save_watch_list_tv_series_event.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/watchlist_tv_series_event.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/watchlist_tv_series_status_event.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchListTvSeriesStatus,
  SaveTvSeriesWatchlist,
  RemoveWatchlistTvSeries,])
void main() {
  late WatchListTvSeriesBloc bloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveTvSeriesWatchlist mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchlistTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveTvSeriesWatchlist();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    bloc = WatchListTvSeriesBloc(
        mockGetWatchlistTvSeries, mockGetWatchlistTvSeriesStatus,
        mockSaveWatchlistTvSeries, mockRemoveWatchlistTvSeries);
  });

  final tId = 1;

  final tvSeries = TvSeries(
    id: 1,
    name: 'Game of Thrones',
    posterPath: '/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
    overview:   "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  );
  final tvSeriesList = <TvSeries>[tvSeries];


  test('initial state should be empty', () {
    expect(bloc.state, EmptyState());
  });

  group('get watch list tv series test cases', () {
    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer((_) async =>
            Right(tvSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListTvSeries()),
      expect: () =>
      [
        LoadingState(),
        HasListDataState(tvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, Error] when get watch list tv series is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListTvSeries()),
      expect: () =>
      [
        LoadingState(),
        ErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );
  });

  group('get watch list status tv series test cases', () {
    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, HasBooleanData(true)] when status is success',
      build: () {
        when(mockGetWatchlistTvSeriesStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListTvSeriesStatus(tId)),
      expect: () =>
      [
        LoadingState(),
        HasBoolDataState(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeriesStatus.execute(tId));
      },
    );

    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, HasBooleanData(false)] when status is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListTvSeriesStatus(tId)),
      expect: () =>
      [
        LoadingState(),
        HasBoolDataState(false),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeriesStatus.execute(tId));
      },
    );
  });

  group('add tv series to watch list test cases', () {
    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, HasMessageData] when successfully added',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer((_) async => Right("Added to watchlist"));
        return bloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchListTvSeries(testTvSeriesDetail)),
      expect: () =>
      [
        LoadingState(),
        HasMessageDataState("Added to watchlist"),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, Error] when unsuccessfully added',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to  save in watchlist')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchListTvSeries(testTvSeriesDetail)),
      expect: () =>
      [
        LoadingState(),
        ErrorState('Failed to  save in watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );
  });

  group('remove tv series to watch list test cases', () {
    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, HasMessageData] when successfully removed',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer((_) async => Right("Removed from watchlist"));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchListTvSeries(testTvSeriesDetail)),
      expect: () =>
      [
        LoadingState(),
        HasMessageDataState("Removed from watchlist"),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<WatchListTvSeriesBloc, DefaultState>(
      'Should emit [Loading, Error] when unsuccessfully removed',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to remove from watchlist')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchListTvSeries(testTvSeriesDetail)),
      expect: () =>
      [
        LoadingState(),
        ErrorState('Failed to remove from watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );
  });
}



