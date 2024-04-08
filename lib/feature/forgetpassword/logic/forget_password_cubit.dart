
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/forget_password_model.dart';

import '../../../core/imports/app_routes_imports.dart';
import '../data/models/check_code_model.dart';
import '../data/models/reset_password.dart';
import '../data/repo/forget_password_repo.dart';
import '../data/repo/check_code_repo.dart';
import '../data/repo/reset_password_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo,this.verifyCodeRepo,this.resetPasswordRepo) : super(ForgetPasswordInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();


  late ForgetPasswordRepo forgetPasswordRepo;
  Future<void> forgetPassword(String path, dynamic data) async {
    emit(ForgetPasswordLoading());
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


  late CheckCodeRepo verifyCodeRepo;
  Future<void> checkCode(String path, dynamic data) async {
    emit(CheckCodeLoading());
    final forgetPassword = await verifyCodeRepo.verfiyCode(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(CheckCodeFailure(error: error));
    }, (checkCode) {
      emit(CheckCodeSuccess(checkCodeModel: checkCode));
    });
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKeyResetPassword = GlobalKey<FormState>();

  late ResetPasswordRepo resetPasswordRepo;
  Future<void> resetPassword(String path, dynamic data) async {
    emit(ResetPasswordLoading());
    final forgetPassword = await resetPasswordRepo.resetPassword(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(ResetPasswordFailure(error: error));
    }, (resetPassword) {

      emit(ResetPasswordSuccess(resetPasswordModel: resetPassword));
    });
  }


}
