import 'dart:async';

import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/movie_detail_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/default_event.dart';

class MovieDetailBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super((EmptyState())) {
    on<OnMovieDetail>(_onMovieDetail);
  }

  FutureOr<void> _onMovieDetail(OnMovieDetail event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getMovieDetail.execute(event.id);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasObjectDataState(data));
    });
  }
}