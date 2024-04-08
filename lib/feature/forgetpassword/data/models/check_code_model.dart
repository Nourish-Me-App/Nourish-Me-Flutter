import 'package:json_annotation/json_annotation.dart';
part 'check_code_model.g.dart';

@JsonSerializable()
class CheckCodeModel {
  final String? message, status;

  final Map<String, dynamic>? data;
  final String? email;
  final String? token;

  CheckCodeModel({
    this.message,
    this.status,
    this.data,
    this.email,
    this.token,
  });

  factory CheckCodeModel.fromJson(Map<String, dynamic> json) =>
      _$CheckCodeModelFromJson(json);

  Map<String, dynamic> toJson(CheckCodeModel checkCodeModel) =>
      _$CheckCodeModelToJson(checkCodeModel);
}
