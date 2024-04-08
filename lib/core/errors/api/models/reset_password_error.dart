

import 'package:json_annotation/json_annotation.dart';
part 'reset_password_error.g.dart';
@JsonSerializable()
class ResetPasswordErrorModel {
  String? message;
  Map<String, dynamic>? errors;
  String? err;

  ResetPasswordErrorModel({
    this.err,
    this.message,
    this.errors,
  }) {
    if (errors != null) {
      err = errors!["email"][0];
    } else {
      err = message;
    }
  }

  factory ResetPasswordErrorModel.fromjson(Map<String, dynamic> json) =>
      _$ResetPasswordErrorModelFromJson(json);
}
