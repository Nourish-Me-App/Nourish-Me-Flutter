import 'package:json_annotation/json_annotation.dart';

part 'signup_error_model.g.dart';

@JsonSerializable()
class SignUpErrorModel {
  String? message;
 
  SignUpErrorModel({
    this.message,
    
  });

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpErrorModelFromJson(json);
}
