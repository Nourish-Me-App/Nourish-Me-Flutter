part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final ForgetPasswordModel? forgetPasswordModel;
  ForgetPasswordSuccess({this.forgetPasswordModel});
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final String? error;
  ForgetPasswordFailure({this.error});
}

final class ForgetPasswordCodeLoading extends ForgetPasswordState {}

final class ForgetPasswordCodeSuccess extends ForgetPasswordState {
  final ForgetPasswordCodeSuccess? forgetPasswordCodeSuccess;
  ForgetPasswordCodeSuccess({this.forgetPasswordCodeSuccess});
}

final class ForgetPasswordCodeFailure extends ForgetPasswordState {
  final String? error;
  ForgetPasswordCodeFailure({this.error});
}
