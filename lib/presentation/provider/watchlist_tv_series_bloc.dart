import 'dart:async';

import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/presentation/eventandstate/default_event.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/watchlist_tv_series_status_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/remove_watchlist_tv_series.dart';
import '../../domain/usecases/save_watchlist_tv_series.dart';
import '../eventandstate/tvseries/event/remove_watch_list_tv_series_event.dart';
import '../eventandstate/tvseries/event/save_watch_list_tv_series_event.dart';
import '../eventandstate/tvseries/event/watchlist_tv_series_event.dart';

class WatchListTvSeriesBloc extends Bloc<DefaultEvent, DefaultState> {

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final GetWatchListTvSeriesStatus _getWatchListTvSeriesStatus;
  final SaveTvSeriesWatchlist _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  WatchListTvSeriesBloc(this._getWatchlistTvSeries, this._getWatchListTvSeriesStatus, this._saveWatchlistTvSeries, this._removeWatchlistTvSeries) : super((EmptyState())) {
    on<OnWatchListTvSeries>(_onWatchListTvSeries);
    on<OnWatchListTvSeriesStatus>(_onWatchListTvSeriesStatus);
    on<OnSaveWatchListTvSeries>(_onSaveWatchListTvSeries);
    on<OnRemoveWatchListTvSeries>(_onRemoveWatchlistTvSeries);
  }

  FutureOr<void> _onWatchListTvSeries(OnWatchListTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getWatchlistTvSeries.execute();

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(EmptyState())
          : emit(HasListDataState(data));
    });
  }

  FutureOr<void> _onWatchListTvSeriesStatus(OnWatchListTvSeriesStatus event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _getWatchListTvSeriesStatus.execute(event.id);
    emit(HasBoolDataState(result));

  }

  FutureOr<void> _onSaveWatchListTvSeries(OnSaveWatchListTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _saveWatchlistTvSeries.execute(event.tvSeriesDetail);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasMessageDataState(data));
    });
  }

  FutureOr<void> _onRemoveWatchlistTvSeries(OnRemoveWatchListTvSeries event, Emitter<DefaultState> emit) async {

    emit(LoadingState());

    final result = await _removeWatchlistTvSeries.execute(event.tvSeriesDetail);

    result.fold((failure) {
      emit(ErrorState(failure.message));
    }, (data) {
      emit(HasMessageDataState(data));
    });
  }
}