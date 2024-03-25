import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/remove_watch_list_movie_event.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/save_watch_list_movie_event.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/watchlist_movie_status_event.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/watchlist_movies_event.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListMovieStatus,
  SaveMovieWatchlist,
  RemoveWatchlistMovie,])
void main() {
  late WatchListMovieBloc bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovie;
  late MockGetWatchListMovieStatus mockGetWatchlistMovieStatus;
  late MockSaveMovieWatchlist mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    mockGetWatchlistMovieStatus = MockGetWatchListMovieStatus();
    mockSaveWatchlistMovie = MockSaveMovieWatchlist();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    bloc = WatchListMovieBloc(
        mockGetWatchlistMovie, mockGetWatchlistMovieStatus,
        mockSaveWatchlistMovie, mockRemoveWatchlistMovie);
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];


  test('initial state should be empty', () {
    expect(bloc.state, EmptyState());
  });

  group('get watch list movie test cases', () {
    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovie.execute()).thenAnswer((_) async =>
            Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListMovies()),
      expect: () =>
      [
        LoadingState(),
        HasListDataState(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovie.execute());
      },
    );

    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, Error] when get watch list movie is unsuccessful',
      build: () {
        when(mockGetWatchlistMovie.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListMovies()),
      expect: () =>
      [
        LoadingState(),
        ErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovie.execute());
      },
    );
  });

  group('get watch list status movie test cases', () {
    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, HasBooleanData(true)] when status is success',
      build: () {
        when(mockGetWatchlistMovieStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListMovieStatus(tId)),
      expect: () =>
      [
        LoadingState(),
        HasBoolDataState(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovieStatus.execute(tId));
      },
    );

    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, HasBooleanData(false)] when status is unsuccessful',
      build: () {
        when(mockGetWatchlistMovieStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchListMovieStatus(tId)),
      expect: () =>
      [
        LoadingState(),
        HasBoolDataState(false),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovieStatus.execute(tId));
      },
    );
  });

  group('add movie to watch list test cases', () {
    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, HasMessageData] when successfully added',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer((_) async => Right("Added to watchlist"));
        return bloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchListMovie(testMovieDetail)),
      expect: () =>
      [
        LoadingState(),
        HasMessageDataState("Added to watchlist"),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
      },
    );

    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, Error] when unsuccessfully added',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to  save in watchlist')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchListMovie(testMovieDetail)),
      expect: () =>
      [
        LoadingState(),
        ErrorState('Failed to  save in watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
      },
    );
  });

  group('remove movie to watch list test cases', () {
    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, HasMessageData] when successfully removed',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer((_) async => Right("Removed from watchlist"));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchListMovie(testMovieDetail)),
      expect: () =>
      [
        LoadingState(),
        HasMessageDataState("Removed from watchlist"),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      },
    );

    blocTest<WatchListMovieBloc, DefaultState>(
      'Should emit [Loading, Error] when unsuccessfully removed',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to remove from watchlist')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchListMovie(testMovieDetail)),
      expect: () =>
      [
        LoadingState(),
        ErrorState('Failed to remove from watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      },
    );
  });
}



