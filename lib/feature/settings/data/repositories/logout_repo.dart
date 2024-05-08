import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/logout_model.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class LogoutRepo {
  late ApiServices apiServices;
  LogoutRepo(this.apiServices);
  Future<Either<String, LogoutModel>> logout(
    String path,
    String token,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      LogoutModel result = LogoutModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
