part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomePageChanged extends HomeEvent {
  final int index;
  final String backgroundUrl;

  HomePageChanged(this.index, this.backgroundUrl);
}