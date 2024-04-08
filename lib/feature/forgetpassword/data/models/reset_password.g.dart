part of 'reset_password.dart';

ResetPasswordModel _$ResetPasswordModelFromJson(Map<String, dynamic> json) =>
    ResetPasswordModel(
      email: json['email'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      newPassword: json['new_password'] as String?,
      newPasswordConfirmation: json['new_password_confirmation'] as String?,
    );

Map<String, dynamic> _$ResetPasswordModelToJson(ResetPasswordModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'email': instance.email,
      'new_password': instance.newPassword,
      'new_password_confirmation': instance.newPasswordConfirmation,
    };
