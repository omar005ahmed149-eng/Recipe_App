import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/core/bloc/movies/movies_state.dart';
import 'package:movies/core/models/Movie_Model.dart';
import 'package:movies/core/models/Movies_Data.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(const MoviesState());

  void setPoster(String path) {
    emit(state.copyWith(selectedPoster: path));
  }

  bool isBookmarked(MovieModel movie) =>
      state.watchList.any((m) => m.title == movie.title);

  void toggleBookmark(MovieModel movie) {
    final updated = [...state.watchList];
    final index = updated.indexWhere((m) => m.title == movie.title);
    if (index >= 0) {
      updated.removeAt(index);
    } else {
      updated.add(movie);
    }
    emit(state.copyWith(watchList: updated));
    _saveToFirestore();
  }

  void addToHistory(MovieModel movie) {
    final updated = [...state.history];
    updated.removeWhere((m) => m.title == movie.title);
    updated.insert(0, movie);
    emit(state.copyWith(history: updated));
    _saveToFirestore();
  }

  Future<void> loadFromFirestore() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      final doc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      final data = doc.data();
      if (data == null) return;

      final rawHistory = List<dynamic>.from(data['history'] ?? []);
      final rawWatchList = List<dynamic>.from(data['watchList'] ?? []);

      final history = <MovieModel>[];
      for (final item in rawHistory) {
        final movie = _movieFromStored(item);
        if (movie != null) history.add(movie);
      }

      final watchList = <MovieModel>[];
      for (final item in rawWatchList) {
        final movie = _movieFromStored(item);
        if (movie != null) watchList.add(movie);
      }

      emit(state.copyWith(history: history, watchList: watchList));
    } catch (e) {
      debugPrint('MoviesCubit.loadFromFirestore error: $e');
    }
  }

  Future<void> _saveToFirestore() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'history': state.history.map(_movieToMap).toList(),
        'watchList': state.watchList.map(_movieToMap).toList(),
      });
    } catch (e) {
      debugPrint('MoviesCubit._saveToFirestore error: $e');
    }
  }

  void clearAll() {
    emit(const MoviesState());
  }

  Map<String, dynamic> _movieToMap(MovieModel movie) {
    return {
      'title': movie.title,
      'rating': movie.rating,
      'poster_image': movie.poster_image,
    };
  }

  MovieModel? _movieFromStored(dynamic item) {
    if (item is Map<String, dynamic>) {
      final title = (item['title'] ?? '').toString();
      final rating = (item['rating'] ?? '').toString();
      final poster = (item['poster_image'] ?? '').toString();
      if (title.isNotEmpty && rating.isNotEmpty && poster.isNotEmpty) {
        return MovieModel(title: title, rating: rating, poster_image: poster);
      }
      return null;
    }
    if (item is String) {
      return _findMovie(item);
    }
    return null;
  }

  MovieModel? _findMovie(String title) {
    try {
      return MovieData.featuredMovies.firstWhere((m) => m.title == title);
    } catch (_) {
      return null;
    }
  }
}
