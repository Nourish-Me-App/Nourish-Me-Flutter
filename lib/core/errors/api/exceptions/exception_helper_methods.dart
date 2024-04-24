import 'package:dio/dio.dart';
import 'package:nourish_me/core/errors/api/models/continue_register/continue_register_error_model.dart';

import '../models/auth/login_error_model.dart';
import '../models/auth/signup_error_model.dart';
import '../models/reset_password/check_code_error_model.dart';
import '../models/reset_password/forget_password_error_model.dart';
import '../models/reset_password/reset_password_error.dart';
import 'api_exception.dart';

class ExceptionHelperMethods {
  ExceptionHelperMethods._();

  static handleDioExceptionsTypes(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throwApiException();
      case DioExceptionType.sendTimeout:
        throwApiException();
      case DioExceptionType.receiveTimeout:
        throwApiException();
      case DioExceptionType.badCertificate:
        throwApiException();
      case DioExceptionType.cancel:
        throwApiException();
      case DioExceptionType.unknown:
        throwApiException();
      case DioExceptionType.badResponse:
        badResponseErrorHandle(e);
      case DioExceptionType.connectionError:
        throw ApiException(
            signUpErrorModel: SignUpErrorModel.fromJson(noInternetErrorMessage),
            loginErrorModel: LoginErrorModel.fromJson(noInternetErrorMessage),
            forgetPasswordErrorModel:
                ForgetPasswordErrorModel.fromJson(noInternetErrorMessage),
            checkCodeErrorModel:
                CheckCodeErrorModel.fromjson(noInternetErrorMessage),
            resetPasswordErrorModel:
                ResetPasswordErrorModel.fromjson(noInternetErrorMessage),
            continueRegisterErrorModel:
                ContinueRegisterErrorModel.fromJson(noInternetErrorMessage));
      default:
        throwApiException();
    }
  }

  static void badResponseErrorHandle(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        badResponseExceptionThrow(e);
      case 401:
        badResponseExceptionThrow(e);
      case 403:
        badResponseExceptionThrow(e);
      case 404:
        badResponseExceptionThrow(e);
      case 409:
        badResponseExceptionThrow(e);
      case 422:
        badResponseExceptionThrow(e);
      case 502:
        badResponseExceptionThrow(e);
      case 504:
        badResponseExceptionThrow(e);
      case 302:
        badResponseExceptionThrow(e);
      default:
        badResponseExceptionThrow(e);
    }
  }

  static void throwApiException() {
    throw ApiException(
        signUpErrorModel: SignUpErrorModel.fromJson(connectionErrorMessage),
        loginErrorModel: LoginErrorModel.fromJson(connectionErrorMessage),
        forgetPasswordErrorModel:
            ForgetPasswordErrorModel.fromJson(connectionErrorMessage),
        checkCodeErrorModel:
            CheckCodeErrorModel.fromjson(connectionErrorMessage),
        resetPasswordErrorModel:
            ResetPasswordErrorModel.fromjson(connectionErrorMessage),
        continueRegisterErrorModel:
            ContinueRegisterErrorModel.fromJson(connectionErrorMessage));
  }

  static void badResponseExceptionThrow(DioException e) {
    if (e.response != null || e.response!.data != null) {
      if (e.response!.data is String) {
        throw ApiException(
          signUpErrorModel:
              SignUpErrorModel.fromJson({'message': '${e.response!.data}'}),
          loginErrorModel:
              LoginErrorModel.fromJson({'message': '${e.response!.data}'}),
          forgetPasswordErrorModel: ForgetPasswordErrorModel.fromJson(
              {'message': '${e.response!.data}'}),
          checkCodeErrorModel:
              CheckCodeErrorModel.fromjson({'message': '${e.response!.data}'}),
          resetPasswordErrorModel: ResetPasswordErrorModel.fromjson(
              {'message': '${e.response!.data}'}),
          continueRegisterErrorModel: ContinueRegisterErrorModel.fromJson(
              {'message': '${e.response!.data}'}),
        );
      } else if (e.response!.data is Map<String, dynamic>) {
        throw ApiException(
          signUpErrorModel: SignUpErrorModel.fromJson(e.response!.data),
          loginErrorModel: LoginErrorModel.fromJson(e.response!.data),
          forgetPasswordErrorModel:
              ForgetPasswordErrorModel.fromJson(e.response!.data),
          checkCodeErrorModel: CheckCodeErrorModel.fromjson(e.response!.data),
          resetPasswordErrorModel:
              ResetPasswordErrorModel.fromjson(e.response!.data),
          continueRegisterErrorModel:
              ContinueRegisterErrorModel.fromJson(e.response!.data),
        );
      } else {
        throwApiException();
      }
    } else {
      throwApiException();
    }
  }

  static Map<String, dynamic> get connectionErrorMessage =>
      {'message': 'حاول مرة أخري في وقت لاحق'};

  static Map<String, dynamic> get noInternetErrorMessage =>
      {'message': 'لا يوجد إتصال بالإنترنت أو يوجد خطأ في السيرفر'};
}
