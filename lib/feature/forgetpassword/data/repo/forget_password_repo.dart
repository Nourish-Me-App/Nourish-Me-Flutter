import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:nourish_me/feature/forgetpassword/data/models/forget_password_model.dart';

import '../../../../core/api/dio_helpr.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/api/error_file.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';
import '../../../auth/data/models/login_model.dart';

class ForgetPasswordRepo{

  // Future<ForgetPasswordModel> forgetPassword({required String email}) async {
  //   try {
  //     final response = await DioHelper.postData(
  //         data: {'email': email},
  //         url: EndPoints.baseUrl + EndPoints.forgetPassword);
  //     final forgotPasswordModel = ForgetPasswordModel.fromJson(response.data);
  //     log('$forgotPasswordModel');
  //   } on ServerException catch (e) {
  //     log(e.errModel.message.toString());
  //   }
  //   return ForgetPasswordModel();
  // }

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
      return Left(e.loginErrorModel!.message!);
    }
  }
}