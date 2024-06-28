import 'package:dartz/dartz.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';
import '../models/continue_register_model.dart';

class ContinueRegisterRepo {
  late ApiServices apiServices;
  ContinueRegisterRepo(this.apiServices);
  Future<Either<String, ContinueRegisterModel>> continueRegister(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = ContinueRegisterModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
