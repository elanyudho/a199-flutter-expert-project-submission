import 'dart:async';

import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/on_the_air_tv_series_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/default_event.dart';
import '../eventandstate/default_state.dart';

class OnTheAirTvSeriesBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetOnAirTvSeries _getOnTheAirPlayingMovies;

  OnTheAirTvSeriesBloc(this._getOnTheAirPlayingMovies) : super((EmptyState())) {
    on<OnTheAirTvSeries>(_onTheAirTvSeries);
  }

  FutureOr<void> _onTheAirTvSeries(OnTheAirTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getOnTheAirPlayingMovies.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }
}