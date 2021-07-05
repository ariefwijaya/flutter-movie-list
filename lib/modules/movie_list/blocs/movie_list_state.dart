part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListListenerSuccess extends MovieListState {
  final  PagingController<int, MovieModel> pagingController;
  const MovieListListenerSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

// will be added content later
class MovieListFailure extends MovieListState {}
