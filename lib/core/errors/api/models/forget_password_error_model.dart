
import 'package:json_annotation/json_annotation.dart';
part 'forget_password_error_model.g.dart';
@JsonSerializable()

class ForgetPasswordErrorModel {
  String? message;
  Map<String, dynamic>? errors;
  String? err;

  ForgetPasswordErrorModel({
    this.message,
    this.errors,
  }) {
    if (errors != null) {
      err = errors!["email"][0];
    } else {
      err = message;
    }
  }

  factory ForgetPasswordErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordErrorModelFromJson(json);
}
