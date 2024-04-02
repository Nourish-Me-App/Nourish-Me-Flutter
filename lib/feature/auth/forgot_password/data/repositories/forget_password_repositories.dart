import 'dart:developer';

import 'package:nourish_me/core/api/api_consumer.dart';
import 'package:nourish_me/core/api/end_points.dart';
import 'package:nourish_me/feature/auth/forgot_password/data/model/forgot_password.dart';

class ForgetPasswordRepositories {
  final ApiConsumer apiConsumer;
  late ForgotPasswordModel forgotPasswordModel;

  ForgetPasswordRepositories({required this.apiConsumer});

  // this function is used to forget password"send code to user email"

  Future<dynamic> forgetPassword({required String email}) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.forgetPassword,
        data: {'email': email},
      );
      forgotPasswordModel = ForgotPasswordModel.fromJson(response);
      return forgotPasswordModel;
    } catch (e) {
      log(e.toString());
    }
  }

  // this function is used to verify the code sent to the user email

  Future<dynamic> verifyCode({required String email, required String token}) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.forgetPasswordVerify,
        data: {'email': email, 'token': token},
      );
      forgotPasswordModel = ForgotPasswordModel.fromJson(response);
      return forgotPasswordModel;
    } catch (e) {
      log(e.toString());
    }
  }

  // this function is used to reset the password

  Future<dynamic> resetPassword(
      {required String email, required String new_password, required String new_password_confirmation}) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.forgetPasswordReset,
        data: {'email': email, 'new_password': new_password, 'new_password_confirmation': new_password_confirmation},
      );
      forgotPasswordModel = ForgotPasswordModel.fromJson(response);
      return forgotPasswordModel;
    } catch (e) {
      log(e.toString());
    }
  }


}
