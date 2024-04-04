import 'dart:developer';

import '../models/login_model.dart';

import '../../../../core/networking/api_services.dart';

class LoginRepo {
  late ApiServices apiServices;
  LoginRepo(this.apiServices);
  Future<LoginModel> login(String path, dynamic data) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = LoginModel.fromJson(response);
      log('result: ${result.message}');
      return result;
    } catch (e) {
      log('repo: ${e.toString()}');
      rethrow;
    }
  }
}
