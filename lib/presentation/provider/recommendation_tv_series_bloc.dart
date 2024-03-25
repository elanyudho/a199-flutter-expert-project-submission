import 'dart:async';

import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/default_event.dart';
import '../eventandstate/tvseries/event/recommendation_tv_series_event.dart';

class RecommendationTvSeriesBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  RecommendationTvSeriesBloc(this._getTvSeriesRecommendations) : super((EmptyState())) {
    on<OnRecommendationTvSeries>(_onRecommendationTvSeries);
  }

  FutureOr<void> _onRecommendationTvSeries(OnRecommendationTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getTvSeriesRecommendations.execute(event.id);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasListDataState(data));
    });
  }
}