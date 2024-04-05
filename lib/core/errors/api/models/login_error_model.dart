import 'package:json_annotation/json_annotation.dart';

part 'login_error_model.g.dart';

@JsonSerializable()
class LoginErrorModel {
  String? message;
  String? status;
  @JsonKey(name: "status_code")
  int? statusCode;
  LoginErrorModel({this.message, this.status, this.statusCode});
  factory LoginErrorModel.fromJson(Map<String, dynamic> json) =>
      _$LoginErrorModelFromJson(json);
}
