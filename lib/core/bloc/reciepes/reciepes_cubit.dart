import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:recipes/core/bloc/reciepes/reciepes_state.dart';
import 'package:recipes/core/models/recipe_Model.dart';

import '../../models/recipes_Data.dart';

class ReciepesCubit extends Cubit<ReciepesState> {
  ReciepesCubit() : super(const ReciepesState());

  void setPoster(String path) {
    emit(state.copyWith(selectedPoster: path));
  }

  bool isBookmarked(ReciepeModel reciepe) =>
      state.watchList.any((m) => m.title == reciepe.title);

  void toggleBookmark(ReciepeModel reciepe) {
    final updated = [...state.watchList];
    final index = updated.indexWhere((m) => m.title == reciepe.title);
    if (index >= 0) {
      updated.removeAt(index);
    } else {
      updated.add(reciepe);
    }
    emit(state.copyWith(watchList: updated));
    _saveToFirestore();
  }

  void addToHistory(ReciepeModel reciepe) {
    final updated = [...state.history];
    updated.removeWhere((m) => m.title == reciepe.title);
    updated.insert(0, reciepe);
    emit(state.copyWith(history: updated));
    _saveToFirestore();
  }

  Future<void> loadFromFirestore() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = doc.data();
      if (data == null) return;

      final rawHistory = List<dynamic>.from(data['history'] ?? []);
      final rawWatchList = List<dynamic>.from(data['watchList'] ?? []);

      final history = <ReciepeModel>[];
      for (final item in rawHistory) {
        final reciepe = _reciepeFromStored(item);
        if (reciepe != null) history.add(reciepe);
      }

      final watchList = <ReciepeModel>[];
      for (final item in rawWatchList) {
        final reciepe = _reciepeFromStored(item);
        if (reciepe != null) watchList.add(reciepe);
      }

      emit(state.copyWith(history: history, watchList: watchList));
    } catch (e) {
      debugPrint('ReciepesCubit.loadFromFirestore error: $e');
    }
  }

  Future<void> _saveToFirestore() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'history': state.history.map(_reciepeToMap).toList(),
        'watchList': state.watchList.map(_reciepeToMap).toList(),
      });
    } catch (e) {
      debugPrint('ReciepesCubit._saveToFirestore error: $e');
    }
  }

  void clearAll() {
    emit(const ReciepesState());
  }

  Map<String, dynamic> _reciepeToMap(ReciepeModel reciepe) {
    return {
      'title': reciepe.title,
      'rating': reciepe.rating,
      'poster_image': reciepe.poster_image,
    };
  }

  ReciepeModel? _reciepeFromStored(dynamic item) {
    if (item is Map<String, dynamic>) {
      final title = (item['title'] ?? '').toString();
      final rating = (item['rating'] ?? '').toString();
      final poster = (item['poster_image'] ?? '').toString();
      if (title.isNotEmpty && rating.isNotEmpty && poster.isNotEmpty) {
        return ReciepeModel(title: title, rating: rating, poster_image: poster);
      }
      return null;
    }
    if (item is String) {
      return _findReciepe(item);
    }
    return null;
  }

  ReciepeModel? _findReciepe(String title) {
    try {
      return ReciepeData.featuredReciepes.firstWhere((m) => m.title == title);
    } catch (_) {
      return null;
    }
  }
}
