import 'dart:developer';

import '../models/signup_model.dart';

import '../../../../core/networking/api_services.dart';

class SignUpRepo {
  late ApiServices apiServices;
  SignUpRepo(this.apiServices);
  Future<SignUpModel> signUp(String path, dynamic data) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = SignUpModel.fromJson(response);
      log('result: ${result.message}');
      return result;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
