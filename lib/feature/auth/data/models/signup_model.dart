import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';

@JsonSerializable()
class SignUpModel {
  final String? message, status;
  final String? name, email, password;
  @JsonKey(name: 'password_confirmation')
  final String? passwordConfirmation;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  SignUpModel({
    this.message,
    this.status,
    this.statusCode,
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson(SignUpModel signUpModel) =>
      _$SignUpModelToJson(signUpModel);
}
