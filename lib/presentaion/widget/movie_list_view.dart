import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/model/movie.dart';
import '../state/movie_list_notifier.dart';
import '../state/provider.dart';

class MovieListView extends ConsumerWidget {
  final List<Movie> movieList;

  const MovieListView({super.key, required this.movieList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieListNotifier = ref.watch(movieNotifierProvider.notifier);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
          //User Scrolled from bottom
          Fluttertoast.showToast(msg: "Loading...",toastLength: Toast.LENGTH_SHORT);

          movieListNotifier.getMovieList(); // Fetch more movies
        }
        return true;
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.red,

            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(

                      width: 400,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: movieList[index].backdropPath,
                          placeholder: (_, __) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieList[index].originalTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text("Vote: ${movieList[index].voteCount}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}