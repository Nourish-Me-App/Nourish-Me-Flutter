import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../models/forget_password_model.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class ForgetPasswordRepo {
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
      log(e.errorModel.message!);
      return Left(e.errorModel.message!);
    }
  }
}
