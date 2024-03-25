import '../../default_event.dart';

class OnWatchListMovieStatus extends DefaultEvent {

  final int id;

  OnWatchListMovieStatus(this.id);

  @override

  List<Object?> get props => [];
}