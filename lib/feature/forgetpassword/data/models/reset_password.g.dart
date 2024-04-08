part of 'reset_password.dart';

ResetPasswordModel _$ResetPasswordModelFromJson(Map<String, dynamic> json) =>
    ResetPasswordModel(
      email: json['email'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      new_password: json['new_password'] as String?,
      new_password_confirmation: json['new_password_confirmation'] as String?,
    );

Map<String, dynamic> _$ResetPasswordModelToJson(ResetPasswordModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'email': instance.email,
      'new_password': instance.new_password,
      'new_password_confirmation': instance.new_password_confirmation,
    };
