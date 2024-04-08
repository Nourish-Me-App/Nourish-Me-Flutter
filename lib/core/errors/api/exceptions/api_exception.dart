
import '../models/check_code_error_model.dart';
import '../models/forget_password_error_model.dart';
import '../models/login_error_model.dart';
import '../models/reset_password_error.dart';
import '../models/signup_error_model.dart';

class ApiException implements Exception {
  final SignUpErrorModel? signUpErrorModel;
  final LoginErrorModel? loginErrorModel;
  final ForgetPasswordErrorModel? forgetPasswordErrorModel;
  final CheckCodeErrorModel? checkCodeErrorModel;
  final ResetPasswordErrorModel? resetPasswordErrorModel;


  ApiException( {this.signUpErrorModel,this.checkCodeErrorModel,this.resetPasswordErrorModel,  this.loginErrorModel,this.forgetPasswordErrorModel});
}
