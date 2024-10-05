import 'package:dio/dio.dart';
import 'package:movie/data/database/database_helper.dart';
import '../model/movie.dart';


class FetchAndStoreLocalStorage {
  final Dio dio = Dio();
  final apiKey = '8c396d3bd56394d191afe324c1df9cbf';// Replace with your actual API key
  final DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Movie>> fetchAllMovies(int page) async {
    String dataPath =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=$page";

    var response = await dio.getUri(Uri.parse(dataPath));

    if (response.statusCode == 200) {
      List<Movie> movies = (response.data['results'] as List).map((movie) {
        return Movie.fromJson(movie);
      }).toList();

      for (var movie in movies) {
        await databaseHelper.insertMovie(movie);
      }

      return movies;
    } else {
      throw Exception("Failed to load Movie Lists. Check your internet connection.");
    }
  }
}
