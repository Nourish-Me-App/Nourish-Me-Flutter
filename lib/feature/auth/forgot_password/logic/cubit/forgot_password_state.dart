part of 'forgot_password_cubit.dart';

class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailure(this.message);
}

class ForgotPasswordVerifyInitial extends ForgotPasswordState {}

class ForgotPasswordVerifyLoading extends ForgotPasswordState {}

class ForgotPasswordVerifySuccess extends ForgotPasswordState {}

class ForgotPasswordVerifyFailure extends ForgotPasswordState {
  final String message;

  ForgotPasswordVerifyFailure(this.message);
}

class ForgotPasswordResetInitial extends ForgotPasswordState {}

class ForgotPasswordResetLoading extends ForgotPasswordState {}

class ForgotPasswordResetSuccess extends ForgotPasswordState {}

class ForgotPasswordResetFailure extends ForgotPasswordState {
  final String message;

  ForgotPasswordResetFailure(this.message);
}
