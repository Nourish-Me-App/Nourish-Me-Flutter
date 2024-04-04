import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/api/dio_helpr.dart';
import '../../../../core/api/end_points.dart';
import '../model/forgot_password.dart';

class ResetPasswordRepositories{


  Future<ForgotPasswordModel> resetPassword(
      {required String email, required String newpassword,required String confirmpassword}) async {
    try {
      final response =
          await DioHelper.postData(url: EndPoints.forgetPasswordReset, data: {
        'email': email,
        'new_password': newpassword,
        'new_password_confirmation': confirmpassword,
      });
      final forgotPasswordModel = ForgotPasswordModel.fromJson(response.data);
      log(forgotPasswordModel.message!);
    } on DioException catch (e) {
      log(e.response.toString());
    }
    return ForgotPasswordModel();
  }
}