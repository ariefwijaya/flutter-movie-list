import 'package:flutter_movie_list/modules/movie_list/models/movie_model.dart';
import 'package:flutter_movie_list/modules/movie_list/repositories/movie_list_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'movie_list_repository_test.mocks.dart';

@GenerateMocks([MovieListRepository])
void main() {
  test('Test Get Movie list', () async {
    final movieListRepository = MockMovieListRepository();
    final expected = successResponse();

    when(movieListRepository.getMovie(1)).thenAnswer((_) async => expected);

    var res = await movieListRepository.getMovie(1);
    expect(res.runtimeType, <MovieModel>[].runtimeType);
  });
}

List<MovieModel> successResponse() {
  return [
    MovieModel(
        id: 13640,
        overview:
            "When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics' publications in the 1990s.",
        posterPath: "/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg",
        releaseDate: DateTime.tryParse("2007-09-18")!,
        title: "Superman: Doomsday")
  ];
}
