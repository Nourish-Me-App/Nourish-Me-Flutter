// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpErrorModel _$SignUpErrorModelFromJson(Map<String, dynamic> json) =>
    SignUpErrorModel(
      message: json['message'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
    )..err = json['err'] as String?;

Map<String, dynamic> _$SignUpErrorModelToJson(SignUpErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'err': instance.err,
    };
