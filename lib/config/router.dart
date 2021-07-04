import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/core/constant/router_const.dart';
import 'package:flutter_movie_list/modules/movie_detail/screens/movie_detail_screen.dart';
import 'package:flutter_movie_list/modules/movie_list/screens/movie_list_screen.dart';

/// Routes Configuration and Management
class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterConst.root:
        return MaterialPageRoute(builder: (_) => MovieListScreen());
      case RouterConst.detail:
        return MaterialPageRoute(
            builder: (_) => MovieDetailScreen(), settings: routeSettings);
      default: //redirect to appinfoview
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
                Scaffold());
    }
  }
}
