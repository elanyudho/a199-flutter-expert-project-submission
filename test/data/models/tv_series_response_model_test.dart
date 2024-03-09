import 'dart:convert';

import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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
  final tvSeriesResponseModel = TvSeriesResponse(page: 1, totalPages: 1, totalResults: 1, results: <TvSeriesModel>[tvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "backdrop_path": "/abcdef.jpg",
            "genre_ids": [18, 28],
            "id": 12345,
            "name": "TV Series 1",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Original TV Series 1",
            "overview": "This is the overview of TV Series 1",
            "popularity": 8.5,
            "poster_path": "/poster123.jpg",
            "vote_average": 8.0,
            "vote_count": 100
          }
        ],
        "total_pages": 1,
        "total_results": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
