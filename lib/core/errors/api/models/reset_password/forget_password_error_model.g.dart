part of 'forget_password_error_model.dart';

ForgetPasswordErrorModel _$ForgetPasswordErrorModelFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordErrorModel(
      message: json['message'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
    )..err = json['err'] as String?;
