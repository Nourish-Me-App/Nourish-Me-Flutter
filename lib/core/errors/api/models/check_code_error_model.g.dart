

part of 'check_code_error_model.dart';



CheckCodeErrorModel _$CheckCodeErrorModelFromJson(Map<String, dynamic> json) =>
    CheckCodeErrorModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CheckCodeErrorModelToJson(
        CheckCodeErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
