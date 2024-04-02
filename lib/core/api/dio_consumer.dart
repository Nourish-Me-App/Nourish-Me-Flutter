import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nourish_me/core/api/api_consumer.dart';

import 'end_points.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future delete(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      log(e.toString());
    }
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      log(e.toString());
    }
  }
}
