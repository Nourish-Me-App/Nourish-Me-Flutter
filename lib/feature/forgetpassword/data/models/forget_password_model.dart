import 'package:json_annotation/json_annotation.dart';
part 'forget_password_model.g.dart';
@JsonSerializable()
class ForgetPasswordModel {
  final String? message, status;
  final Map<String, dynamic>? data;
  final String? email;

  ForgetPasswordModel({
    this.message,
    this.status,
    this.data,
    this.email,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordModelFromJson(json);

  Map<String, dynamic> toJson(ForgetPasswordModel forgetPasswordModel) =>
      _$ForgetPasswordModelToJson(forgetPasswordModel);
}
