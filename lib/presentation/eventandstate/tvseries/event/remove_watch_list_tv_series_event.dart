import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

import '../../default_event.dart';

class OnRemoveWatchListTvSeries extends DefaultEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnRemoveWatchListTvSeries(this.tvSeriesDetail);

  @override

  List<Object?> get props => [];
}