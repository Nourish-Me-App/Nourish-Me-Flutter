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

final class UpdateProfileLoading extends SettingsState {}

final class UpdateProfileSuccess extends SettingsState {
  final UpdateProfileModel updateProfileModel;

  UpdateProfileSuccess({required this.updateProfileModel});
}

final class UpdateProfileFailed extends SettingsState {
  final String error;

  UpdateProfileFailed({required this.error});
}

final class ImagePicked extends SettingsState {}
