class ForgotPasswordModel {
  String? message;
  String? status;
  int? statusCode;

  ForgotPasswordModel({this.message, this.status, this.statusCode});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['status_code'] = statusCode;
    return data;
  }
}