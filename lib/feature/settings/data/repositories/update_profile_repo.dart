import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nourish_me/feature/settings/data/models/update_profile_model.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class UpdateProfileRepo {
  late ApiServices apiServices;
  UpdateProfileRepo(this.apiServices);
  Future<Either<String, UpdateProfileModel>> updateProfile(
    String path,
    String token,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
        isFormData: true,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      UpdateProfileModel result = UpdateProfileModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
