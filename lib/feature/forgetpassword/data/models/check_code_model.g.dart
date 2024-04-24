// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckCodeModel _$CheckCodeModelFromJson(Map<String, dynamic> json) =>
    CheckCodeModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      email: json['email'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$CheckCodeModelToJson(CheckCodeModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'email': instance.email,
      'token': instance.token,
    };
