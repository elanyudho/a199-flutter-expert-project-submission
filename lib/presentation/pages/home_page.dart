import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/movie/event/top_rated_movie_event.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/on_the_air_tv_series_event.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/provider/on_the_air_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/popular_movie_bloc.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/movie/event/now_playing_movie_event.dart';
import '../eventandstate/movie/event/popular_movie_event.dart';
import '../eventandstate/tvseries/event/popular_tv_series_event.dart';
import '../eventandstate/tvseries/event/top_rated_tv_series_event.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var menuState = MenuState.movies;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<PopularMovieBloc>(context, listen: false)
          .add(OnPopularMovie());
      BlocProvider.of<TopRatedMovieBloc>(context, listen: false)
          .add(OnTopRatedMovie());
      BlocProvider.of<NowPlayingMovieBloc>(context, listen: false)
          .add(OnNowPlayingMovie());

      BlocProvider.of<PopularTvSeriesBloc>(context, listen: false)
          .add(OnPopularTvSeries());
      BlocProvider.of<TopRatedTvSeriesBloc>(context, listen: false)
          .add(OnTopRatedTvSeries());
      BlocProvider.of<OnTheAirTvSeriesBloc>(context, listen: false)
          .add(OnTheAirTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Movies'),
                onTap: () {
                  setState(() {
                    menuState = MenuState.movies;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tv),
                title: Text('Tv Series'),
                onTap: () {
                  setState(() {
                    menuState = MenuState.tvSeries;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('Watchlist'),
                onTap: () {
                  Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                },
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Ditonton'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: switch (menuState) {
          MenuState.movies => _buildMoviePage(context),
          MenuState.tvSeries => _buildTvSeriesPage(context),
        });
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoviePage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMovieBloc, DefaultState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HasListDataState) {
                return MovieList(state.result as List<Movie>);
              } else if (state is ErrorState) {
                return Text(state.message);
              } else {
                return Text("State Not Found");
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularMovieBloc, DefaultState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HasListDataState) {
                return MovieList(state.result as List<Movie>);
              } else if (state is ErrorState) {
                return Text(state.message);
              } else {
                return Text("State Not Found");
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedMovieBloc, DefaultState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HasListDataState) {
                return MovieList(state.result as List<Movie>);
              } else if (state is ErrorState) {
                return Text(state.message);
              } else {
                return Text("State Not Found");
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTvSeriesPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On Air',
              style: kHeading6,
            ),
            BlocBuilder<OnTheAirTvSeriesBloc, DefaultState>(builder: (context, state) {
              if (state is LoadingState ) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HasListDataState) {
                return TvSeriesList(state.result as List<TvSeries>);
              } else if (state is ErrorState){
                return Text(state.message);
              } else {
                return Text("State Not Found");
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvSeriesBloc, DefaultState>(builder: (context, state) {
              if (state is LoadingState ) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HasListDataState) {
                return TvSeriesList(state.result as List<TvSeries>);
              } else if (state is ErrorState){
                return Text(state.message);
              } else {
                return Text("State Not Found");
              }
            }),
            BlocBuilder<TopRatedTvSeriesBloc, DefaultState>(builder: (context, state) {
              if (state is LoadingState ) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HasListDataState) {
                return TvSeriesList(state.result as List<TvSeries>);
              } else if (state is ErrorState){
                return Text(state.message);
              } else {
                return Text("State Not Found");
              }
            }),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}

enum MenuState { movies, tvSeries }
