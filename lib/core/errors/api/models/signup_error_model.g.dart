// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpErrorModel _$SignUpErrorModelFromJson(Map<String, dynamic> json) =>
    SignUpErrorModel(
      message: json['message'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
    )..err =
        json['errors'] != null ? json['errors']['email'][0] as String? : '';
