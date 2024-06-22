class UpdateProfileModel {
  String? message;
  String? status;
  int? statusCode;
  Data? data;

  UpdateProfileModel({this.message, this.status, this.statusCode, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? image;

  Data({this.image});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
}
