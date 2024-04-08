

import 'package:json_annotation/json_annotation.dart';
part 'check_code_error_model.g.dart';
@JsonSerializable()
class CheckCodeErrorModel{
  final String? message, status;
  CheckCodeErrorModel({
    this.message,
    this.status,
  });

  factory CheckCodeErrorModel.fromjson(Map<String, dynamic> json) => _$CheckCodeErrorModelFromJson(json);
}