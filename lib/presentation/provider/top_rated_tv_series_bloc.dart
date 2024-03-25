import 'dart:async';

import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/eventandstate/default_event.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/tvseries/event/top_rated_tv_series_event.dart';

class TopRatedTvSeriesBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeries) : super((EmptyState())) {
    on<OnTopRatedTvSeries>(_onTopRatedTvSeries);
  }

  FutureOr<void> _onTopRatedTvSeries(OnTopRatedTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getTopRatedTvSeries.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }
}