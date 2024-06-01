import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';
import '../models/diets_model.dart';

class DietsRepo {
  late ApiServices apiServices;
  DietsRepo(this.apiServices);

  Future<Either<String, DietsModel>> getDietMeals(
      String path, String token) async {
    try {
      var response = await apiServices.get(
        path,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      DietsModel result = DietsModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
