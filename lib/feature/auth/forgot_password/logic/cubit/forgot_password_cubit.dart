import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourish_me/feature/auth/forgot_password/data/repositories/forget_password_repositories.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.forgetPasswordRepositories)
      : super(ForgotPasswordInitial());

  final ForgetPasswordRepositories forgetPasswordRepositories;

  // this key for forgetPassword form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // this controller for email text field
  TextEditingController emailController = TextEditingController();

  // this function to send email to user to forget password

  forgetPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    try {
      await forgetPasswordRepositories.forgetPassword(
          email: emailController.text);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  // this key for forgetPassword form
  GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>();
  // this controller for email text field
  TextEditingController codeController = TextEditingController();

  // this function to verify code that sent to user email

  verifyCode({required String email, required String token}) async {
    emit(ForgotPasswordVerifyLoading());
    try {
      await forgetPasswordRepositories.verifyCode(email: email, token: token);
      emit(ForgotPasswordVerifySuccess());
    } catch (e) {
      emit(ForgotPasswordVerifyFailure(e.toString()));
    }
  }

  // this key for resetPassword form
  GlobalKey<FormState> formKeyReset = GlobalKey<FormState>();
  // this controller for newPasswordController text field
  TextEditingController newPasswordController = TextEditingController();
  // this controller for newPasswordConfirmationController text field
  TextEditingController newPasswordConfirmationController =
      TextEditingController();
  // this controller for email text field
  TextEditingController emailResetController = TextEditingController();

  // this function to reset password

  resetPassword(
      {required String email,
      required String new_password,
      required String new_password_confirmation}) async {
    emit(ForgotPasswordResetLoading());
    try {
      await forgetPasswordRepositories.resetPassword(
          email: emailResetController.text,
          new_password: newPasswordController.text,
          new_password_confirmation: newPasswordConfirmationController.text);
      emit(ForgotPasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordResetFailure(e.toString()));
    }
  }
}
