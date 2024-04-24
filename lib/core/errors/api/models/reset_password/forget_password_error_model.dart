import 'package:json_annotation/json_annotation.dart';
part 'forget_password_error_model.g.dart';

@JsonSerializable()
class ForgetPasswordErrorModel {
  String? message;

  ForgetPasswordErrorModel({
    this.message,
  }) ;

  factory ForgetPasswordErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordErrorModelFromJson(json);
}
