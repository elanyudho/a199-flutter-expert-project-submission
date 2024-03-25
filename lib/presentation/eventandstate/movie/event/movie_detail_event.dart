import '../../default_event.dart';

class OnMovieDetail extends DefaultEvent {
  final int id;

  OnMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}