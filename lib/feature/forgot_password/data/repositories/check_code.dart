import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nourish_me/core/api/dio_helpr.dart';
import 'package:nourish_me/core/api/end_points.dart';

import '../model/forgot_password.dart';

class CheckCodeRepository {
  Future<ForgotPasswordModel> chcekCode(
      {required String email, required String token}) async {
    try {
      final response =
          await DioHelper.postData(url: EndPoints.forgetPasswordVerify, data: {
        'email': email,
        'token': token,
      });
      final forgotPasswordModel = ForgotPasswordModel.fromJson(response.data);
      log(forgotPasswordModel.message!);
    } on DioException catch (e) {
      log(e.response.toString());
    }
    return ForgotPasswordModel();
  }
}
