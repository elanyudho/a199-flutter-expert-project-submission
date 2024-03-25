import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/movie/event/watchlist_movies_event.dart';
import '../eventandstate/tvseries/event/watchlist_tv_series_event.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchListMovieBloc>(context, listen: false)
            .add(OnWatchListMovies()));
    Future.microtask(() =>
        BlocProvider.of<WatchListTvSeriesBloc>(context, listen: false)
            .add(OnWatchListTvSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchListMovieBloc>(context, listen: false)
        .add(OnWatchListMovies());
    BlocProvider.of<WatchListTvSeriesBloc>(context, listen: false)
        .add(OnWatchListTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(tabs: [Tab(text: 'Movies'), Tab(text: 'Tv Series')],
            indicatorSize: TabBarIndicatorSize.tab),
      ),
      body: TabBarView(
        children: [
          _buildWatchlistMovieView(context),
          _buildWatchlistTvSeriesView(context)
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Widget _buildWatchlistMovieView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchListMovieBloc, DefaultState>(
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
              child: Text('State Not Found'),
            );
          }
        },
      ),
    );
  }

  Widget _buildWatchlistTvSeriesView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchListTvSeriesBloc, DefaultState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HasListDataState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.result[index];
                return TvSeriesCard(tvSeries);
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
              child: Text('State Not Found'),
            );
          }
        },
      ),
    );
  }
}
