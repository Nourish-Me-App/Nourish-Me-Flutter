part of 'check_code_error_model.dart';

CheckCodeErrorModel _$CheckCodeErrorModelFromJson(Map<String, dynamic> json) =>
    CheckCodeErrorModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
    );
