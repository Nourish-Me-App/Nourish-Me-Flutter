import 'package:dartz/dartz.dart';
import '../models/check_code_model.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class CheckCodeRepo {
  late ApiServices apiServices;

  CheckCodeRepo(this.apiServices);

  Future<Either<String, CheckCodeModel>> verfiyCode(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = CheckCodeModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
