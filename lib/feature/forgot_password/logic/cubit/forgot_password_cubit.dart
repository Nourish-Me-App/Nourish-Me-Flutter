import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/feature/forgot_password/data/model/forgot_password.dart';
import 'package:nourish_me/feature/forgot_password/data/repositories/forget_password_repo.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(
    this.foregetPasswordRepoSitories,
  ) : super(ForgotPasswordInitial());
  late ForegetPasswordRepoSitories foregetPasswordRepoSitories;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Future<ForgotPasswordModel> forgetPassword() async {
    emit(ForgotPasswordLoading());
    try {
      final forgotPasswordModel = await foregetPasswordRepoSitories
          .forgetPassword(email: emailController.text);
      log('$forgotPasswordModel');
      emit(ForgotPasswordSuccess());
    } catch (e) {
      log(e.toString());
      emit(ForgotPasswordFailure());
    }
    return ForgotPasswordModel();
  }


  //Future<void> forgetPassword() async {
  //   emit(ForgotPasswordLoading());

  //   final forgotPasswordModel = await foregetPasswordRepoSitories
  //       .forgetPassword(email: emailController.text);

  //   forgotPasswordModel.fold((error) {
  //     emit(ForgotPasswordFailure(error: error));
  //   }, (forgotPasswordModel) {
  //     emit(ForgotPasswordSuccess(forgotPasswordModel: forgotPasswordModel));
  //   });
  // }
  
}
