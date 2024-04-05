part of 'forgot_password_cubit.dart';

class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordModel? forgotPasswordModel;

  ForgotPasswordSuccess({this.forgotPasswordModel});
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String? error;
  ForgotPasswordFailure({this.error});
}
