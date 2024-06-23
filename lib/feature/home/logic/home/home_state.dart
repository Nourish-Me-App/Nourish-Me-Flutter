part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeModel homeModel;
  HomeSuccessState({required this.homeModel});
}

class HomeFailureState extends HomeState {
  final String error;
  HomeFailureState({required this.error});
}
