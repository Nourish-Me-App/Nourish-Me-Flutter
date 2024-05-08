class LogoutModel {
  final String? message;
  final String? status;
  final int? statusCode;

  LogoutModel({this.message, this.status, this.statusCode});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      message: json['message'],
      status: json['status'],
      statusCode: json['status_code'],
    );
  }
}
