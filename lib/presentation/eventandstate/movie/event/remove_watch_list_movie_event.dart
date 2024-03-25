import 'package:ditonton/domain/entities/movie_detail.dart';

import '../../default_event.dart';

class OnRemoveWatchListMovie extends DefaultEvent {
  final MovieDetail movieDetail;

  OnRemoveWatchListMovie(this.movieDetail);

  @override

  List<Object?> get props => [];
}