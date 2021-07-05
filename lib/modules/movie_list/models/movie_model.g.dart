// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    id: json['id'] as int,
    title: json['title'] as String,
    overview: json['overview'] as String,
    posterPath: json['poster_path'] as String?,
    releaseDate: json['release_date'] as String?,
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: (json['vote_count'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
