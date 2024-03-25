import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/eventandstate/default_state.dart';
import 'package:ditonton/presentation/eventandstate/tvseries/event/watchlist_tv_series_status_event.dart';
import 'package:ditonton/presentation/provider/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/constants.dart';
import '../../domain/entities/genre.dart';
import '../eventandstate/tvseries/event/recommendation_tv_series_event.dart';
import '../eventandstate/tvseries/event/remove_watch_list_tv_series_event.dart';
import '../eventandstate/tvseries/event/save_watch_list_tv_series_event.dart';
import '../eventandstate/tvseries/event/tv_series_detail_event.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvSeriesDetailBloc>(context, listen: false)
          .add(OnTvSeriesDetail(widget.id));
      BlocProvider.of<WatchListTvSeriesBloc>(context, listen: false)
          .add(OnWatchListTvSeriesStatus(widget.id));
      BlocProvider.of<RecommendationTvSeriesBloc>(context, listen: false)
          .add(OnRecommendationTvSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    final isTvSeriesAddedToWatchList = context.select<WatchListTvSeriesBloc, bool>((bloc) {
      if (bloc.state is HasBoolDataState) {
        return (bloc.state as HasBoolDataState).result;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, DefaultState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HasObjectDataState) {
            final tvSeries = state.result;
            return SafeArea(
              child: DetailTvSeriesContent(
                tvSeries,
                _getTvSeriesList(buildContext),
                isTvSeriesAddedToWatchList,
              ),
            );
          }else if (state is ErrorState) {
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
    );
  }

  List<TvSeries> _getTvSeriesList(BuildContext context) {
    final recommendationState = context.read<RecommendationTvSeriesBloc>().state;
    if (recommendationState is HasListDataState) {
      return recommendationState.result as List<TvSeries>;
    } else {
      List<TvSeries> emptyList = [];
      return emptyList;    }
  }
}

class DetailTvSeriesContent extends StatefulWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  bool isAddedWatchlist;

  DetailTvSeriesContent(this.tvSeries, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailTvSeriesContent> createState() => _DetailTvSeriesContentState();
}

class _DetailTvSeriesContentState extends State<DetailTvSeriesContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  BlocProvider.of<WatchListTvSeriesBloc>(
                                      context,
                                      listen: false)
                                      .add(OnSaveWatchListTvSeries(widget.tvSeries));
                                } else {
                                  BlocProvider.of<WatchListTvSeriesBloc>(
                                      context,
                                      listen: false)
                                      .add(OnRemoveWatchListTvSeries(widget.tvSeries));
                                }

                                final state = BlocProvider
                                    .of<WatchListTvSeriesBloc>(
                                    context, listen: false)
                                    .state;
                                String message = "";

                                if (state is HasBoolDataState) {
                                  final isAdded = state.result;
                                  message =
                                  isAdded == false
                                      ? WatchListTvSeriesBloc
                                      .watchlistAddSuccessMessage
                                      : WatchListTvSeriesBloc
                                      .watchlistRemoveSuccessMessage;
                                } else {
                                  message = !widget.isAddedWatchlist
                                      ? WatchListTvSeriesBloc
                                      .watchlistAddSuccessMessage
                                      : WatchListTvSeriesBloc
                                      .watchlistRemoveSuccessMessage;
                                }

                                if (message == WatchListTvSeriesBloc
                                    .watchlistAddSuccessMessage ||
                                    message == WatchListTvSeriesBloc
                                        .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  widget.isAddedWatchlist = !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Text(
                              'Total Season: ${widget.tvSeries.numberOfSeasons}'
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            widget.recommendations.isNotEmpty ? Text(
                              'Recommendations',
                              style: kHeading6,
                            ) : Container(),
                            BlocBuilder<RecommendationTvSeriesBloc, DefaultState>(
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is ErrorState) {
                                  return Text(state.message);
                                } else if (state is HasListDataState) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = widget.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
