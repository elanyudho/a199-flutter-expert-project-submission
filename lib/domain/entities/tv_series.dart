import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;

  TvSeries({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath,
  ];
}