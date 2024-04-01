import 'dart:developer';
import '../../feature/auth/data/models/login_model.dart';
import '../../feature/auth/data/models/signup_model.dart';
import '../../feature/auth/logic/cubit/auth_cubit.dart';
import 'app_constants.dart';

class AuthRequests {
  AuthRequests._();
  static Future<void> signUp({
    required AuthCubit authCubit,
    required SignUpModel signUpModel,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    var res = await authCubit.signUp(
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
    log('${res.message}');
  }

  static Future<LoginModel> login({
    required AuthCubit authCubit,
    required LoginModel loginModel,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    var res = await authCubit.login(
      AppConstants.login,
      loginModel.toJson(
        LoginModel(
          email: email,
          password: password,
          rememberMe: rememberMe,
        ),
      ),
    );
    log('${res.data}');
    return res;
  }
}
