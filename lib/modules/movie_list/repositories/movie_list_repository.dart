import 'package:flutter_movie_list/core/constant/api_const.dart';
import 'package:flutter_movie_list/core/models/api_model.dart';
import 'package:flutter_movie_list/core/services/network_service.dart';
import 'package:flutter_movie_list/modules/movie_list/models/movie_list_model.dart';

class MovieListRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<List<MovieListModel>?> getMovie(int page) async {
    Map<String, dynamic> result = await _networkUtils.get(ApiConst.listMovie,
        body: {
          "api_key": "6753d9119b9627493ae129f3c3c99151",
          "query": "superman",
          "page": page
        });

    CApiRes<List<MovieListModel>> response = CApiRes.fromJson(result, (e) {
      List<MovieListModel> movelist = <MovieListModel>[];
      if (e != null) {
        e.forEach((v) {
          movelist.add(new MovieListModel.fromJson(v));
        });
      }
      return movelist;
    });

    return response.results;
  }
}
