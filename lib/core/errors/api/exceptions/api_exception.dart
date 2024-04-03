import '../models/login_error_model.dart';
import '../models/signup_error_model.dart';

class ApiException implements Exception {
  final SignUpErrorModel? signUpErrorModel;
  final LoginErrorModel? loginErrorModel;

  ApiException({this.signUpErrorModel, this.loginErrorModel});
}
