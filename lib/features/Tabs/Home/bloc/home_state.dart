part of 'home_bloc.dart';

class HomeState {
  final int activeIndex;
  final String currentBg;

  String get currentBackgroundUrl =>
      ReciepeData.featuredReciepes[activeIndex].poster_image;

  const HomeState({
    required this.activeIndex,
    required this.currentBg,
  });

  factory HomeState.initial() => HomeState(
        activeIndex: 0,
        currentBg: ReciepeData.featuredReciepes[0].poster_image,
      );

  HomeState copyWith({
    int? activeIndex,
    String? currentBg,
    String? prevBg,
  }) {
    return HomeState(
      activeIndex: activeIndex ?? this.activeIndex,
      currentBg: currentBg ?? this.currentBg,
    );
  }
}
