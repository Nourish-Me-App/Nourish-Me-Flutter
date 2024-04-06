
import '../models/forget_password_error_model.dart';
import '../models/login_error_model.dart';
import '../models/signup_error_model.dart';

class ApiException implements Exception {
  final SignUpErrorModel? signUpErrorModel;
  final LoginErrorModel? loginErrorModel;
  final ForgetPasswordErrorModel? forgetPasswordErrorModel;

  ApiException({this.signUpErrorModel, this.loginErrorModel,this.forgetPasswordErrorModel});
}
