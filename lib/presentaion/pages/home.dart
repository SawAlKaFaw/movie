import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/data/model/movie.dart';
import '../state/movie_state.dart';
import '../state/provider.dart';
import '../widget/movie_error_widget.dart';
import '../widget/movie_list_view.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    // Fetch movies when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      ref.read(movieNotifierProvider.notifier).getMovieList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieListState = ref.watch(movieNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Now Playing Movies",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: switch (movieListState) {
        MovieLoadingState() => const Center(child: CircularProgressIndicator()),
        MovieLoadedState(movieList: List<Movie> movieList) => MovieListView(movieList: movieList),
        MovieErrorState(error: String errorMessage) => MovieErrorWidget(
          errorMessage: errorMessage,
          tryAgain: () {
            ref.read(movieNotifierProvider.notifier).getMovieList();
          },
        ),
      },

    );
  }
}