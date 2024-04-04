import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nourish_me/core/api/end_points.dart';
import 'package:nourish_me/core/api/error_file.dart';
import 'package:nourish_me/core/api/dio_helpr.dart';
import '../model/forgot_password.dart';

class ForegetPasswordRepoSitories {
  Future<ForgotPasswordModel> forgetPassword({required String email}) async {
    try {
      final response = await DioHelper.postData(
          data: {'email': email},
          url: EndPoints.baseUrl + EndPoints.forgetPassword);
      final forgotPasswordModel = ForgotPasswordModel.fromJson(response.data);
      log('$forgotPasswordModel');
    } on ServerException catch (e) {
      log(e.errModel.message.toString());
    }
    return ForgotPasswordModel();
  }

  // Future<ForgotPasswordModel> chcekCode(
  //     {required String email, required String token}) async {
  //   try {
  //     final response =
  //         await DioHelper.postData(url: EndPoints.forgetPasswordVerify, data: {
  //       'email': email,
  //       'token': token,
  //     });
  //     final forgotPasswordModel = ForgotPasswordModel.fromJson(response.data);
  //     log(forgotPasswordModel.message!);
  //   } on DioException catch (e) {
  //     log(e.response.toString());
  //   }
  //   return ForgotPasswordModel();
  // }

}
