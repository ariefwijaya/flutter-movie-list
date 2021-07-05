part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class MovieListFetched extends MovieListEvent {
  final int page;
   const MovieListFetched(this.page);

  @override
  List<Object> get props => [page];
}

class MovieListRegisterListener extends MovieListEvent {}