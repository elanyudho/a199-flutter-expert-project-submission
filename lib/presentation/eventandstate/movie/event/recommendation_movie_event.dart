import '../../default_event.dart';

class OnRecommendationMovie extends DefaultEvent {
  final int id;

  OnRecommendationMovie(this.id);

  @override
  List<Object?> get props => [];
}