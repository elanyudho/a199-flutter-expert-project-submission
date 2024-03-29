import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/provider/movie_search_bloc.dart';
import 'package:ditonton/presentation/provider/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventandstate/search/search_event.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var filter = FilterState.Movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (query) {
                      filter == FilterState.Movie
                          ? context.read<SearchMovieBloc>().add(OnQueryChanged(query))
                          : context.read<SearchTvSeriesBloc>().add(OnQueryChanged(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  child: Icon(Icons.filter_list_outlined),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _filterDialog(context);
                        });
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            filter == FilterState.Movie
                ? _buildMovieSearchResultView(context)
                : _buildTvSeriesSearchResultView(context)
          ],
        ),
      ),
    );
  }

  Widget _buildMovieSearchResultView(BuildContext context) {
    return BlocBuilder<SearchMovieBloc, DefaultState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HasListDataState) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is ErrorState) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget _buildTvSeriesSearchResultView(BuildContext context) {
    return BlocBuilder<SearchTvSeriesBloc, DefaultState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HasListDataState) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvSeries = result[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is ErrorState) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget _filterDialog(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: kColorScheme.primaryContainer,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Filter',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kRichBlack),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text('Movie', style: TextStyle(color: kRichBlack)),
              leading: Icon(Icons.movie, color: kRichBlack),
              onTap: () {
                setState(() {
                  filter = FilterState.Movie;
                });
                Navigator.of(context).pop('Movies');
              },
            ),
            ListTile(
              title: Text('TV Series', style: TextStyle(color: kRichBlack)),
              leading: Icon(Icons.live_tv, color: kRichBlack),
              onTap: () {
                setState(() {
                  filter = FilterState.TvSeries;
                });
                Navigator.of(context).pop('TV Series');
              },
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
