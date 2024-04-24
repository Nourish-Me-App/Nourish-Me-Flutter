import 'package:json_annotation/json_annotation.dart';

part 'reset_password_error.g.dart';

@JsonSerializable()
class ResetPasswordErrorModel {
  String? message;

  ResetPasswordErrorModel({
    this.message,
  });

  factory ResetPasswordErrorModel.fromjson(Map<String, dynamic> json) =>
      _$ResetPasswordErrorModelFromJson(json);
}
