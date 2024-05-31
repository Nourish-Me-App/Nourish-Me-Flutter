import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';
import '../model/home_model.dart';

class HomeRepo {
  late ApiServices apiServices;
  HomeRepo(this.apiServices);
  Future<Either<String, HomeModel>> getHomeData(
    String path,
    String token,
  ) async {
    try {
      var response = await apiServices.get(
        path,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      var result = HomeModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
