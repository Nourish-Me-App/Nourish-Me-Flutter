class ContinueRegisterModel {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? status;
  int? statusCode;
  String? message;
  String? gender;
  String? age;
  String? weight;
  String? height;
  Data? data;

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
      this.height,
      this.data});

  factory ContinueRegisterModel.fromJson(Map<String, dynamic> json) {
    return ContinueRegisterModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        passwordConfirmation: json['password_confirmation'] as String?,
        status: json['status'] as String?,
        statusCode: (json['status_code'] as num?)?.toInt(),
        message: json['message'] as String?,
        gender: json['gender'] as String?,
        age: json['age'] as String?,
        weight: json['weight'] as String?,
        height: json['height'] as String?,
        data: json['data'] != null ? Data.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson(ContinueRegisterModel continueRegisterModel) {
    return <String, dynamic>{
      'name': continueRegisterModel.name,
      'email': continueRegisterModel.email,
      'password': continueRegisterModel.password,
      'password_confirmation': continueRegisterModel.passwordConfirmation,
      'gender': continueRegisterModel.gender,
      'age': continueRegisterModel.age,
      'weight': continueRegisterModel.weight,
      'height': continueRegisterModel.height,
    };
  }
}

class Data {
  String? massIndex;

  Data({this.massIndex});

  Data.fromJson(Map<String, dynamic> json) {
    massIndex = json['mass_index'];
  }
}
