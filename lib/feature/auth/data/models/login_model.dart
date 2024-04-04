import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
 final  String? message, status;
 final  Map<String, dynamic>? data;
 final String? email, password;

  @JsonKey(name: 'remember')
 final bool? rememberMe;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  LoginModel({
     this.message,
     this.status,
     this.statusCode,
    this.data,
    this.email,
    this.password,
    this.rememberMe,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson(LoginModel loginModel) =>
      _$LoginModelToJson(loginModel);
}
