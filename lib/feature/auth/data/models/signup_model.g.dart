// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      statusCode: json['status_code'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'status_code': instance.statusCode,
    };
