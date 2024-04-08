import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:nourish_me/core/networking/api_services.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/reset_password.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';

class ResetPasswordRepo{
  late ApiServices apiServices;
  ResetPasswordRepo(this.apiServices);

  Future<Either<String, ResetPasswordModel>> resetPassword(
      String path,
      dynamic data,
      ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = ResetPasswordModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      log(e.resetPasswordErrorModel!.message!);
      return Left(e.resetPasswordErrorModel!.message!);
    }
  }
}