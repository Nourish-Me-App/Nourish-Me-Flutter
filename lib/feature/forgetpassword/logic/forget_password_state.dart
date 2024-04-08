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

final class CheckCodeLoading extends ForgetPasswordState {}

final class CheckCodeSuccess extends ForgetPasswordState {
  final CheckCodeModel? checkCodeModel;
  CheckCodeSuccess({this.checkCodeModel});
}

final class CheckCodeFailure extends ForgetPasswordState {
  final String? error;
  CheckCodeFailure({this.error});
}

final class ResetPasswordLoading extends ForgetPasswordState {}

final class ResetPasswordSuccess extends ForgetPasswordState {
  final ResetPasswordModel? resetPasswordModel;
  ResetPasswordSuccess({this.resetPasswordModel});
}

final class ResetPasswordFailure extends ForgetPasswordState {
  final String? error;
  ResetPasswordFailure({this.error});
}
