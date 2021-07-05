import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/modules/movie_list/blocs/movie_list_bloc.dart';
import 'package:flutter_movie_list/modules/movie_list/models/movie_list_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieListScreen extends StatefulWidget {
  MovieListScreen({Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
   final PagingController<int, MovieListModel> _pagingController =
      PagingController(firstPageKey: 0);

   late MovieListBloc movieListBloc;

      @override
  void initState() {
    movieListBloc = MovieListBloc(_pagingController)..add(MovieListRegisterListener());
    super.initState();
  }

  @override
  void dispose() {
    movieListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView<int, MovieListModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieListModel>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.title),
            subtitle: Text(item.overview),
            leading: CachedNetworkImage(imageUrl: item.posterPath) ,
          ),
        ),
      ),
    );
  }
}