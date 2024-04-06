import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/forget_password_model.dart';

import '../../../core/imports/app_routes_imports.dart';
import '../data/repo/forget_password_repo.dart';
import '../data/repo/verify_code_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo,this.verifyCodeRepo) : super(ForgetPasswordInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  // Future<ForgetPasswordModel> forgetPassword() async {
  //   emit(ForgetPasswordLoading());
  //   try {
  //     final forgotPasswordModel = await ForgetPasswordRepo().forgetPassword(
  //       email: emailController.text,
  //     );
  //
  //     log('$forgotPasswordModel');
  //     emit(ForgetPasswordSuccess());
  //   } catch (e) {
  //     log(e.toString());
  //     emit(ForgetPasswordFailure());
  //   }
  //   return ForgetPasswordModel();
  // }
  late ForgetPasswordRepo forgetPasswordRepo;
  Future<void> forgetPassword(String path, dynamic data) async {
    emit(ForgetPasswordCodeLoading());
    final forgetPassword = await forgetPasswordRepo.forgetPassword(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(ForgetPasswordFailure(error: error));
    }, (forgetPassword) {
      emit(ForgetPasswordSuccess(forgetPasswordModel: forgetPassword));
    });
  }

  TextEditingController codeController = TextEditingController();
  GlobalKey<FormState> formKeyCode = GlobalKey<FormState>();


  late VerifyCodeRepo verifyCodeRepo;
  Future<void> verifyCode(String path, dynamic data) async {
    emit(ForgetPasswordCodeLoading());
    final forgetPassword = await verifyCodeRepo.verfiyCode(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(ForgetPasswordFailure(error: error));
    }, (forgetPassword) {
      emit(ForgetPasswordSuccess(forgetPasswordModel: forgetPassword));
    });
  }

// Future verifyCode({
//   required String email,
//   required String token,
// }) async {
//   try {
//     emit(ForgetPasswordCodeLoading());
//     await VerifyCodeRepo().chcekCode(email: email, token: token);
//     emit(ForgetPasswordCodeSuccess());
//   } on Exception catch (e) {
//     log(e.toString());
//     emit(ForgetPasswordFailure());
//   }
// }
}
