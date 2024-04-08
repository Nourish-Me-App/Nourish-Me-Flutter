import '../models/auth/login_error_model.dart';
import '../models/auth/signup_error_model.dart';
import '../models/reset_password/check_code_error_model.dart';
import '../models/reset_password/forget_password_error_model.dart';
import '../models/reset_password/reset_password_error.dart';

class ApiException implements Exception {
  final SignUpErrorModel? signUpErrorModel;
  final LoginErrorModel? loginErrorModel;
  final ForgetPasswordErrorModel? forgetPasswordErrorModel;
  final CheckCodeErrorModel? checkCodeErrorModel;
  final ResetPasswordErrorModel? resetPasswordErrorModel;

  ApiException({
    this.signUpErrorModel,
    this.checkCodeErrorModel,
    this.resetPasswordErrorModel,
    this.loginErrorModel,
    this.forgetPasswordErrorModel,
  });
}
