import 'package:json_annotation/json_annotation.dart';

part 'signup_error_model.g.dart';

@JsonSerializable()
class SignUpErrorModel {
  String? message;
  Map<String, dynamic>? errors;
  String? err;
  SignUpErrorModel({
    this.message,
    this.errors,
  }) {
    if (errors != null) {
      err = errors!["email"][0];
    } else {
      err = message;
    }
  }

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpErrorModelFromJson(json);
}
