import 'dart:async';

import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/default_event.dart';
import '../eventandstate/tvseries/event/tv_series_detail_event.dart';

class TvSeriesDetailBloc extends Bloc<DefaultEvent, DefaultState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super((EmptyState())) {
    on<OnTvSeriesDetail>(_onTvSeriesDetail);
  }

  FutureOr<void> _onTvSeriesDetail(OnTvSeriesDetail event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getTvSeriesDetail.execute(event.id);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasObjectDataState(data));
    });
  }
}