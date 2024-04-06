class ForgetPasswordErrorModel {
  String? message;
  Errors? errors;

  ForgetPasswordErrorModel({this.message, this.errors});

  ForgetPasswordErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}