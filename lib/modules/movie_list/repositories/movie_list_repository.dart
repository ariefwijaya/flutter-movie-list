import 'package:flutter_movie_list/core/constant/api_const.dart';
import 'package:flutter_movie_list/core/models/api_model.dart';
import 'package:flutter_movie_list/core/services/network_service.dart';
import 'package:flutter_movie_list/modules/movie_list/models/movie_model.dart';

class MovieListRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<List<MovieModel>?> getMovie(int page) async {
    Map<String, dynamic> result = await _networkUtils.get(ApiConst.listMovie,
        body: {
          "api_key": "6753d9119b9627493ae129f3c3c99151",
          "query": "superman",
          "page": page
        });

    CApiRes<List<MovieModel>> response = CApiRes.fromJson(result, (e) {
      List<MovieModel> movelist = <MovieModel>[];
      if (e != null) {
        e.forEach((v) {
          if (v['poster_path'] != null) {
            v['poster_path'] =
                "http://image.tmdb.org/t/p/w92${v['poster_path']}";
          }
           if (v['backdrop_path'] != null) {
            v['backdrop_path'] =
                "http://image.tmdb.org/t/p/w185${v['backdrop_path']}";
          }


          movelist.add(new MovieModel.fromJson(v));
        });
      }
      return movelist;
    });

    return response.results;
  }
}
