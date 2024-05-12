part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}
final class LogoutLoading extends SettingsState {}
final class LogoutSuccess extends SettingsState {
  final LogoutModel logoutModel;

  LogoutSuccess({required this.logoutModel});
}
final class LogoutFailed extends SettingsState {
  final String error;

  LogoutFailed({required this.error});
}
