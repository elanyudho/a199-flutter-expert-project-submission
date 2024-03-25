import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/on_the_air_tv_series_event.dart';
import 'package:ditonton/presentation/provider/on_the_air_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_the_air_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTvSeries])
void main() {
  late MockGetOnAirTvSeries mockOnTheAirTvSeries;
  late OnTheAirTvSeriesBloc bloc;

  setUp(() {
    mockOnTheAirTvSeries = MockGetOnAirTvSeries();
    bloc = OnTheAirTvSeriesBloc(mockOnTheAirTvSeries);
  });

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

  blocTest<OnTheAirTvSeriesBloc, DefaultState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockOnTheAirTvSeries.execute()).thenAnswer((_) async => Right(tvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvSeries()),
    expect: () => [
      LoadingState(),
      HasListDataState(tvSeriesList),
    ],
    verify: (bloc) {
      verify(mockOnTheAirTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvSeriesBloc, DefaultState>(
    'Should emit [Loading, Error] when get on the air tv series is unsuccessful',
    build: () {
      when(mockOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvSeries()),
    expect: () => [
      LoadingState(),
      ErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockOnTheAirTvSeries.execute());
    },
  );
}
