part of 'home_bloc.dart';

class HomeState {
  final int activeIndex;
  final String currentBg;

  String get currentBackgroundUrl => currentBg;

  const HomeState({
    required this.activeIndex,
    required this.currentBg,
  });

  factory HomeState.initial() => const HomeState(
    activeIndex: 0,
    currentBg: '',
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