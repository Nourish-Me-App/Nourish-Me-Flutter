// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordErrorModel _$ResetPasswordErrorModelFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordErrorModel(
      err: json['err'] as String?,
      message: json['message'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ResetPasswordErrorModelToJson(
        ResetPasswordErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'err': instance.err,
    };
