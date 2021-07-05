import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  final String overview;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "release_date")
  final DateTime releaseDate;
  final bool? adult;
  @JsonKey(name: "backdrop_path")
  final bool? backdropPath;
  final double? popularity;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final double? voteCount;

  MovieModel(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      this.adult,
      this.backdropPath,
      this.popularity,
      this.voteAverage,
      this.voteCount});

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
