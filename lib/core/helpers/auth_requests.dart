import 'package:nourish_me/core/api/end_points.dart';
import 'package:nourish_me/core/errors/api/models/forget_password_error_model.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/forget_password_model.dart';
import 'package:nourish_me/feature/forgetpassword/data/repo/forget_password_repo.dart';

import '../../feature/auth/data/models/login_model.dart';
import '../../feature/auth/data/models/signup_model.dart';
import '../../feature/auth/logic/cubit/auth_cubit.dart';
import '../../feature/forgetpassword/logic/forget_password_cubit.dart';
import 'app_constants.dart';

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
    await authCubit.signUp(
      AppConstants.register,
      signUpModel.toJson(
        SignUpModel(
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
          name: name,
        ),
      ),
    );
  }
//   static Future forgetPassword({
//     required ForgetPasswordModel forgetPasswordModel,
//     required String email,
// }) async{
//     await ForgetPasswordCubit.forgetPassword(
//       EndPoints.forgetPassword,
//       forgetPasswordModel.toJson(
//         ForgetPasswordrModel(
//
//         )
//       ),
//
//
//     )
//   }

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
