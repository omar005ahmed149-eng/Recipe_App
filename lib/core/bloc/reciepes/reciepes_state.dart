import 'package:recipes/core/models/recipe_Model.dart';

class ReciepesState {
  final String selectedPoster;
  final List<ReciepeModel> watchList;
  final List<ReciepeModel> history;

  const ReciepesState({
    this.selectedPoster = '',
    this.watchList = const [],
    this.history = const [],
  });

  ReciepesState copyWith({
    String? selectedPoster,
    List<ReciepeModel>? watchList,
    List<ReciepeModel>? history,
  }) {
    return ReciepesState(
      selectedPoster: selectedPoster ?? this.selectedPoster,
      watchList: watchList ?? this.watchList,
      history: history ?? this.history,
    );
  }
}
