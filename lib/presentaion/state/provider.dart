import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movie_list_notifier.dart';
import 'movie_state.dart';

final movieNotifierProvider = NotifierProvider<MovieListNotifier, MovieState>(
      () => MovieListNotifier(),
);