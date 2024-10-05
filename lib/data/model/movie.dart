import 'package:movie/data/config/constant.dart';

class Movie {
  final int id;
  final String originalTitle;
  final String backdropPath;
  final String overview;
  final int voteCount;

  Movie({
    required this.id,
    required this.originalTitle,
    required this.backdropPath,
    required this.overview,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      originalTitle: json['original_title'],
      backdropPath: Constant.imageBaseUrl+Constant.backDropPath,
      overview: json['overview'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_title': originalTitle,
      'backdrop_path': backdropPath,
      'overview': overview,
      'vote_count': voteCount,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      originalTitle: map['original_title'],
      backdropPath: map['backdrop_path'],
      overview: map['overview'],
      voteCount: map['vote_count'],
    );
  }
}