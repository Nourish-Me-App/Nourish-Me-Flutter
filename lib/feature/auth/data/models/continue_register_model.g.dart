// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continue_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContinueRegisterModel _$ContinueRegisterModelFromJson(
        Map<String, dynamic> json) =>
    ContinueRegisterModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      status: json['status'] as String?,
      statusCode: json['status_code'] as int?,
      message: json['message'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as String?,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
    );

Map<String, dynamic> _$ContinueRegisterModelToJson(
        ContinueRegisterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'gender': instance.gender,
      'age': instance.age,
      'weight': instance.weight,
      'height': instance.height,
    };
