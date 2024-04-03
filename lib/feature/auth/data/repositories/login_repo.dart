import 'package:dartz/dartz.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../models/login_model.dart';

import '../../../../core/networking/api_services.dart';

class LoginRepo {
  late ApiServices apiServices;
  LoginRepo(this.apiServices);
  Future<Either<String, LoginModel>> login(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = LoginModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.loginErrorModel!.message!);
    }
  }
}
