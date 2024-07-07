part of 'data_screen_cubit.dart';

@immutable
sealed class DataScreenState {}

final class DataScreenInitial extends DataScreenState {}

final class ContinueRegisterSuccess extends DataScreenState {}

final class ContinueRegisterLoading extends DataScreenState {}

final class ContinueRegisterFailure extends DataScreenState {
  final String? error;
  ContinueRegisterFailure({this.error});
}

final class ContinueGoogleRegisterSuccess extends DataScreenState {}

final class ContinueGoogleRegisterLoading extends DataScreenState {}

final class ContinueGoogleRegisterFailure extends DataScreenState {
  final String? error;
  ContinueGoogleRegisterFailure({this.error});
}

final class LoadingCounter extends DataScreenState {}

final class IncreamentCounter extends DataScreenState {}

final class DecreamentCounter extends DataScreenState {}

final class UpdateAgeCounter extends DataScreenState {}
