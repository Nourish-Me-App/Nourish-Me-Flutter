import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

@JsonSerializable()
class ResetPasswordModel {
  final String? message, status;
  final Map<String, dynamic>? data;
  final String? email;
  final String? new_password;
  final String? new_password_confirmation;

  ResetPasswordModel({
    this.email,
    this.message,
    this.status,
    this.data,
    this.new_password,
    this.new_password_confirmation,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson(ResetPasswordModel resetPassword) =>
      _$ResetPasswordModelToJson(resetPassword);
}
