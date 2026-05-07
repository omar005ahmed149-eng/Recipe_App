import 'package:movies/core/models/Movie_Model.dart';

class MoviesState {
  final String selectedPoster;
  final List<MovieModel> watchList;
  final List<MovieModel> history;

  const MoviesState({
    this.selectedPoster = '',
    this.watchList = const [],
    this.history = const [],
  });

  MoviesState copyWith({
    String? selectedPoster,
    List<MovieModel>? watchList,
    List<MovieModel>? history,
  }) {
    return MoviesState(
      selectedPoster: selectedPoster ?? this.selectedPoster,
      watchList: watchList ?? this.watchList,
      history: history ?? this.history,
    );
  }
}
