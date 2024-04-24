// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginErrorModel _$LoginErrorModelFromJson(Map<String, dynamic> json) =>
    LoginErrorModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      statusCode: json['status_code'] as int?,
    );

Map<String, dynamic> _$LoginErrorModelToJson(LoginErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'status_code': instance.statusCode,
    };
