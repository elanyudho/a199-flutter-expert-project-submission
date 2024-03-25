import 'dart:async';

import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/eventandstate/default_event.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/tvseries/event/popular_tv_series_event.dart';


class PopularTvSeriesBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries) : super((EmptyState())) {
    on<OnPopularTvSeries>(_onPopularTvSeries);
  }

  FutureOr<void> _onPopularTvSeries(OnPopularTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getPopularTvSeries.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }
}