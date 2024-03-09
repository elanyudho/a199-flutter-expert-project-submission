import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/watch_list_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = WatchListTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// Tv Series
final testTvSeriesTable = WatchListTable(
  id: 1,
  title: 'Game of Thrones',
  posterPath: '/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
  overview:   "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",

);

final testTvSeriesMap = {
  'id': 1,
  'title': 'Game of Thrones',
  'posterPath': '/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
  'overview':   "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",

};

final testTvSeriesWatchList = TvSeries(
  id: 1,
  name: 'Game of Thrones',
  posterPath: '/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
  overview:   "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
);

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: "/6LWy0jvMpmjoS9fojNgHIKoWL05.jpg",
  genres: [
    Genre(id: 10765, name: "Sci-Fi & Fantasy"),
    Genre(id: 18, name: "Drama"),
    Genre(id: 10759, name: "Action & Adventure")
  ],
  id: 1,
  name: "Game of Thrones",
  numberOfSeasons: 8,
  originalName: "Game of Thrones",
  overview:
  "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  popularity: 346.098,
  posterPath: "/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg",
  voteAverage: 8.438,
  voteCount: 21390,
);

final testTvSeriesList = [testTvSeriesWatchList];

