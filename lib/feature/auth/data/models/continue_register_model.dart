import 'package:json_annotation/json_annotation.dart';
part 'continue_register_model.g.dart';

@JsonSerializable()
class ContinueRegisterModel {
  String? name;
  String? email;
  String? password;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;
  String? status;
  @JsonKey(name: 'status_code')
  int? statusCode;
  String? message;
  String? gender;
  String? age;
  String? weight;
  String? height;

  ContinueRegisterModel(
      {this.name,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.status,
      this.statusCode,
      this.message,
      this.gender,
      this.age,
      this.weight,
      this.height
      });

  factory ContinueRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$ContinueRegisterModelFromJson(json);

  Map<String, dynamic> toJson(ContinueRegisterModel continueRegisterModel) =>
      _$ContinueRegisterModelToJson(continueRegisterModel);
}
