import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series.dart';

TvSeriesResponse detailTvSeriesResponseFromJson(String str) => TvSeriesResponse.fromJson(json.decode(str));

String detailTvSeriesResponseToJson(TvSeriesResponse data) => json.encode(data.toJson());

class TvSeriesResponse extends Equatable {
  final int page;
  final List<TvSeriesModel> results;
  final int totalPages;
  final int totalResults;

  TvSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) => TvSeriesResponse(
    page: json["page"],
    results: List<TvSeriesModel>.from(json["results"].map((x) => TvSeriesModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };

  @override
  List<Object?> get props => [results];
}

class TvSeriesModel extends Equatable {
  final String? backdropPath;
  final DateTime firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TvSeriesModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
    backdropPath: json["backdrop_path"],
    firstAirDate: DateTime.parse(json["first_air_date"]),
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? '',
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "name": name,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvSeries toEntity() {
    return TvSeries(
      id: this.id,
      name:  this.name,
      overview: this.overview,
      posterPath: this.posterPath,
    );
  }

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genreIds,
    id,
    name,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];

}



