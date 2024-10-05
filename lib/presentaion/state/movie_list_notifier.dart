import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/database/database_helper.dart';
import 'package:movie/data/datasources/fetch_and_store_local_storage.dart';
import 'movie_state.dart';
import '../../data/model/movie.dart';

class MovieListNotifier extends Notifier<MovieState> {
  final FetchAndStoreLocalStorage _fetchAndStoreLocalStorage =
      FetchAndStoreLocalStorage();
  List<Movie> allMovies = [];
  int currentPage = 1;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  MovieState build() {
    return MovieLoadingState();
  }

  Future<void> getMovieList() async {


    if (currentPage == 1) {
      state = MovieLoadingState(); // Set loading state for the first fetch
    }

    try {
      final List<Movie> movieList =
          await _dbHelper.getAllMovies().then((movies) {
        if (movies.isEmpty) {
          return _fetchAndStoreLocalStorage.fetchAllMovies(currentPage);
        }
        return movies;
      });
      //final List<Movie> movieList = await _fetchAndStoreLocalStorage.fetchAllMovies(currentPage);
      allMovies.addAll(movieList); // Append new movies to the list
      currentPage++; // Increment the page for the next request

      state = MovieLoadedState(allMovies); // Update state with loaded movies
    } catch (e) {
      state = MovieErrorState(
          "Failed to load movies. Check your internet connection.");
    }
  }
}
