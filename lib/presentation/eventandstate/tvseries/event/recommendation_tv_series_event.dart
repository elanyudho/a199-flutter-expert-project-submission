import '../../default_event.dart';

class OnRecommendationTvSeries extends DefaultEvent {
  final int id;

  OnRecommendationTvSeries(this.id);

  @override
  List<Object?> get props => [];
}