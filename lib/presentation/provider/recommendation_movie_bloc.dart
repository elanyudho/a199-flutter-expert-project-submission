import 'dart:async';

import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_movie_recommendations.dart';
import '../eventandstate/default_event.dart';
import '../eventandstate/movie/event/recommendation_movie_event.dart';

class RecommendationMovieBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations) : super((EmptyState())) {
    on<OnRecommendationMovie>(_onRecommendationMovie);
  }

  FutureOr<void> _onRecommendationMovie(OnRecommendationMovie event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getMovieRecommendations.execute(event.id);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasListDataState(data));
    });
  }
}