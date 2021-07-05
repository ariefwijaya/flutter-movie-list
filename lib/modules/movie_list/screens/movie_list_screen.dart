import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/config/app_config.dart';
import 'package:flutter_movie_list/core/constant/router_const.dart';
import 'package:flutter_movie_list/modules/movie_list/blocs/movie_list_bloc.dart';
import 'package:flutter_movie_list/modules/movie_list/models/movie_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'movie_card_widget.dart';

class MovieListScreen extends StatefulWidget {
  MovieListScreen({Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late MovieListBloc movieListBloc;

  @override
  void initState() {
    movieListBloc = MovieListBloc()..add(MovieListRegisterListener());
    super.initState();
  }

  @override
  void dispose() {
    movieListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListBloc>(
      create: (context) => movieListBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppConfig.appName),
        ),
        body: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (context, state) {
            if (state is MovieListListenerSuccess) {
              return PagedListView<int, MovieModel>.separated(
                padding: EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (context, index) {
                  return Divider(thickness: 1);
                },
                pagingController: state.pagingController,
                builderDelegate: PagedChildBuilderDelegate<MovieModel>(
                  itemBuilder: (context, item, index) => MovieListCard(
                      releaseDate:
                         item.releaseDate??"",
                      title: item.title,
                      description: item.overview,
                      image: item.posterPath,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouterConst.detail, arguments: item);
                      }),
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
