import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/search/search_event.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils.dart';

class SearchTvSeriesBloc extends Bloc<SearchEvent, DefaultState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(EmptyState()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(LoadingState());
      final result = await _searchTvSeries.execute(query);

      result.fold(
            (failure) {
              emit(ErrorState(failure.message));
            },
            (data) {
          emit(HasListDataState(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}