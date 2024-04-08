import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/forget_password_model.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class ForgetPasswordRepo{

  late ApiServices apiServices;
  ForgetPasswordRepo(this.apiServices);
  Future<Either<String, ForgetPasswordModel>> forgetPassword(
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
      log(e.forgetPasswordErrorModel!.message!);
      return Left(e.forgetPasswordErrorModel!.message!);
    }
  }
}