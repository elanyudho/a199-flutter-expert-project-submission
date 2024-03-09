import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';


class TvSeriesDetail extends Equatable {
  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    backdropPath,
    genres,
    id,
    name,
    numberOfSeasons,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];
}