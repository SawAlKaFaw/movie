import '../../data/model/movie.dart';

sealed class MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Movie> movieList;

  MovieLoadedState(this.movieList);
}

class MovieErrorState extends MovieState {
  final String error;

  MovieErrorState(this.error);
}
