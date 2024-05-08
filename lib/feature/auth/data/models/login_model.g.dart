// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      data: json['data'] as Map<String, dynamic>?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      rememberMe: json['remember'] as bool?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'email': instance.email,
      'password': instance.password,
      'remember': instance.rememberMe,
      'status_code': instance.statusCode,
    };
