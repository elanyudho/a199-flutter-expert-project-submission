import 'package:ditonton/domain/entities/movie_detail.dart';

import '../../default_event.dart';

class OnSaveWatchListMovie extends DefaultEvent {

  final MovieDetail movieDetail;

  OnSaveWatchListMovie(this.movieDetail);

  @override

  List<Object?> get props => [];
}