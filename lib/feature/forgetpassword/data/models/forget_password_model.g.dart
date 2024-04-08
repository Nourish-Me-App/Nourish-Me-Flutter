// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordModel _$ForgetPasswordModelFromJson(Map<String, dynamic> json) =>
    ForgetPasswordModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ForgetPasswordModelToJson(
        ForgetPasswordModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'email': instance.email,
    };
