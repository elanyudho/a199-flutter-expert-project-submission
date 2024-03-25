import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/search/search_event.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils.dart';

class SearchMovieBloc extends Bloc<SearchEvent, DefaultState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(EmptyState()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(LoadingState());
      final result = await _searchMovies.execute(query);

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