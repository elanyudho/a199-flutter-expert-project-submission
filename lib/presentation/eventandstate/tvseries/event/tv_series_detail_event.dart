import '../../default_event.dart';

class OnTvSeriesDetail extends DefaultEvent {
  final int id;

  OnTvSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}