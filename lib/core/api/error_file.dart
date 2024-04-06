import 'package:dio/dio.dart';

import '../errors/api/models/forget_password_error_model.dart';

class ServerException implements Exception {
  ForgetPasswordErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(
          errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
        case 404: //not found
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
        case 409: //cofficient
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
        case 422: //  Unprocessable Entity
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
        case 504: // Server exception
          throw ServerException(
              errModel: ForgetPasswordErrorModel.fromJson(e.response!.data));
      }
  }
}
