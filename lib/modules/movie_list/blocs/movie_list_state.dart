part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListSuccess extends MovieListState {
  final List<MovieModel> data;
  const MovieListSuccess(this.data);

  @override
  List<Object> get props => [data];
}

// will be added content later
class MovieListFailure extends MovieListState {}
