import '../../feature/auth/data/models/continue_register_model.dart';

import '../../feature/auth/data/models/login_model.dart';
import '../../feature/auth/data/models/signup_model.dart';
import '../../feature/auth/logic/cubit/auth_cubit.dart';
import '../../feature/forgetpassword/data/models/check_code_model.dart';
import '../../feature/forgetpassword/data/models/forget_password_model.dart';
import '../../feature/forgetpassword/data/models/reset_password.dart';
import '../../feature/forgetpassword/logic/forget_password_cubit.dart';
import 'app_constants.dart';
import 'cache_helper.dart';

class AuthRequests {
  AuthRequests._();
  static Future signUp({
    required AuthCubit authCubit,
    required SignUpModel signUpModel,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    await authCubit
        .signUp(
      AppConstants.register,
      signUpModel.toJson(
        SignUpModel(
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
          name: name,
        ),
      ),
    )
        .then((value) {
      CacheHelper cacheHelper = CacheHelper();
      cacheHelper.saveData(
        key: 'email',
        value: email,
      );
      cacheHelper.saveData(
        key: 'password',
        value: password,
      );
      cacheHelper.saveData(
        key: 'name',
        value: name,
      );
      cacheHelper.saveData(
        key: 'passwordConfirmation',
        value: passwordConfirmation,
      );
    });
  }

  static Future continueRegister({
    required AuthCubit authCubit,
    required ContinueRegisterModel continueRegisterModel,
    required String email,
    required String name,
    required String age,
    required String gender,
    required String weight,
    required String height,
    required String password,
    required String passwordConfirmation,
  }) async {
    await authCubit.continueRegister(
      AppConstants.continueRegister,
      continueRegisterModel.toJson(
        ContinueRegisterModel(
          email: email,
          name: name,
          age: age,
          weight: weight,
          height: height,
          gender: gender,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      ),
    );
  }

  static Future forgetPassword({
    required ForgetPasswordCubit forgetPasswordCubit,
    required ForgetPasswordModel forgetPasswordModel,
    required String email,
  }) async {
    await forgetPasswordCubit.forgetPassword(
      AppConstants.forgetPassword,
      forgetPasswordModel.toJson(
        ForgetPasswordModel(
          email: email,
        ),
      ),
    );
  }

  static Future checkCode({
    required ForgetPasswordCubit forgetPasswordCubit,
    required CheckCodeModel checkCodeModel,
    required String email,
    required String token,
  }) async {
    await forgetPasswordCubit.checkCode(
      AppConstants.checkCode,
      checkCodeModel.toJson(
        CheckCodeModel(
          email: email,
          token: token,
        ),
      ),
    );
  }

  static Future resetPassword({
    required ForgetPasswordCubit forgetPasswordCubit,
    required ResetPasswordModel resetPasswordModel,
    required String email,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    await forgetPasswordCubit.resetPassword(
      AppConstants.resetPassword,
      resetPasswordModel.toJson(ResetPasswordModel(
        email: email,
        newpassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      )),
    );
  }

  static Future login({
    required AuthCubit authCubit,
    required LoginModel loginModel,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await authCubit.login(
      AppConstants.login,
      loginModel.toJson(
        LoginModel(
          email: email,
          password: password,
          rememberMe: rememberMe,
        ),
      ),
    );
  }
}
