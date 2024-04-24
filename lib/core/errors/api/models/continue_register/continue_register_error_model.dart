import 'package:json_annotation/json_annotation.dart';
part 'continue_register_error_model.g.dart';

@JsonSerializable()
class ContinueRegisterErrorModel {
  String? message;
  ContinueRegisterErrorModel({
    this.message,
  });

  factory ContinueRegisterErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ContinueRegisterErrorModelFromJson(json);
}
