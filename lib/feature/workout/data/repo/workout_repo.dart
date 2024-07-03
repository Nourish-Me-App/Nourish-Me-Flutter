import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nourish_me/core/errors/api/exceptions/api_exception.dart';
import 'package:nourish_me/core/networking/api_services.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';

class WorkoutRepo {
  late ApiServices apiServices;
  WorkoutRepo(this.apiServices);
  Future<Either<String, WorkOutModel>> fetchWorkout(
      String path, String token) async {
    try {
      var response = await apiServices.get(path,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      WorkOutModel result = WorkOutModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
