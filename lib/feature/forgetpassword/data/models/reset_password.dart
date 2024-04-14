import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

@JsonSerializable()
class ResetPasswordModel {
  final String? message, status;
  final Map<String, dynamic>? data;
  final String? email;
  final String? newPassword;
  final String? newPasswordConfirmation;

  ResetPasswordModel({
    this.email,
    this.message,
    this.status,
    this.data,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson(ResetPasswordModel resetPassword) =>
      _$ResetPasswordModelToJson(resetPassword);
}
