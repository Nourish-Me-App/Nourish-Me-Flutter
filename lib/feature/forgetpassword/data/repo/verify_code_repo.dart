import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/forget_password_model.dart';

import '../../../../core/api/dio_helpr.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class VerifyCodeRepo{
  // Future<ForgetPasswordModel> chcekCode(
  //     {required String email, required String token}) async {
  //   try {
  //     final response =
  //     await DioHelper.postData(url: EndPoints.forgetPasswordVerify, data: {
  //       'email': email,
  //       'token': token,
  //     });
  //     final forgotPasswordModel = ForgetPasswordModel.fromJson(response.data);
  //     log(forgotPasswordModel.message!);
  //   } on DioException catch (e) {
  //     log(e.response.toString());
  //   }
  //   return ForgetPasswordModel();
  // }

  late ApiServices apiServices;
  VerifyCodeRepo(this.apiServices);
  Future<Either<String, ForgetPasswordModel>> verfiyCode(
      String path,
      dynamic data,
      ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = ForgetPasswordModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.loginErrorModel!.message!);
    }
  }
}