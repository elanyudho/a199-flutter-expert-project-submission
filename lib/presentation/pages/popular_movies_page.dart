import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/provider/popular_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/movie/event/popular_movie_event.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularMovieBloc>(context, listen: false)
            .add(OnPopularMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, DefaultState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HasListDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is ErrorState) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("State Not Found"),
              );
            }
          },
        ),
      ),
    );
  }
}
