import 'dart:developer';

import 'package:dio/dio.dart';
import '../helpers/app_constants.dart';

import 'api_services.dart';

class DioHandler extends ApiServices {
  late Dio dio;

  DioHandler() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Connection': 'keep-alive',
      },
    );
    dio = Dio(baseOptions);
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      Response response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      var response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future update(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      Response response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Response response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

}
