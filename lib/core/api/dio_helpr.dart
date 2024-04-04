import 'package:dio/dio.dart';
import 'package:nourish_me/core/api/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token}) async {
    dio.options.headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return dio.post(url, queryParameters: query, data: data);
  }
}
