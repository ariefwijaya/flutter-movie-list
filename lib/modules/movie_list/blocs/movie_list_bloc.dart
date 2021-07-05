import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_list/modules/movie_list/models/movie_model.dart';
import 'package:flutter_movie_list/modules/movie_list/repositories/movie_list_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListInitial());

   final PagingController<int, MovieModel> pagingController =
      PagingController(firstPageKey: 1);
  final _movieListRepository = MovieListRepository();
  int _pageSize = 20;


@override
  Future<void> close() {
    // pagingController.dispose();
    return super.close();
  }
  @override
  Stream<MovieListState> mapEventToState(
    MovieListEvent event,
  ) async* {
    if (event is MovieListFetched) {
      try {
        final int currentPageKey = (event.page/_pageSize).ceil();
        final items = await _movieListRepository.getMovie(currentPageKey);
        final isLastPage = items!.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(items);
        } else {
          final nextPageKey = event.page + items.length;
          pagingController.appendPage(items, nextPageKey);
        }
      } catch (error,s) {
        print(error);
        print(s);
        pagingController.error = error;
      }
    }

    if (event is MovieListRegisterListener) {
      pagingController.addPageRequestListener((pageKey) {
        add(MovieListFetched(pageKey));
      });

      yield MovieListListenerSuccess(pagingController);
    }
  }
}
