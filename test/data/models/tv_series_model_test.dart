import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvSeriesModel = TvSeriesModel(
      backdropPath: "/abcdef.jpg",
      genreIds: [18, 28],
      id: 12345,
      name: "TV Series 1",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Original TV Series 1",
      overview: "This is the overview of TV Series 1",
      popularity: 8.5,
      posterPath: "/poster123.jpg",
      voteAverage: 8.0,
      voteCount: 100
  );

  final tvSeries = TvSeries(
      id: 12345,
      name: "TV Series 1",
      overview: "This is the overview of TV Series 1",
      posterPath: "/poster123.jpg",
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });
}
