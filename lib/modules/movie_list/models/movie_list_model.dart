import 'package:json_annotation/json_annotation.dart';

part 'movie_list_model.g.dart';

@JsonSerializable()
class MovieListModel {
  final int id;
  final String title;
  final String overview;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "release_date")
  final DateTime releaseDate;

  MovieListModel(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.releaseDate});

  factory MovieListModel.fromJson(Map<String, dynamic> json) =>
      _$MovieListModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListModelToJson(this);
}
