class HomeModel {
  String? message;
  String? status;
  int? statusCode;
  Data? data;

  HomeModel({this.message, this.status, this.statusCode, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  String? weightInKG;
  String? heightInCM;
  String? ageInYears;
  String? totalCalories;
  String? massIndex;
  String? dietType;
  String? waterAmount;

  Data(
      {this.weightInKG,
      this.heightInCM,
      this.ageInYears,
      this.totalCalories,
      this.massIndex,
      this.dietType,
      this.waterAmount});

  Data.fromJson(Map<String, dynamic> json) {
    weightInKG = json['weight_in_KG'];
    heightInCM = json['height_in_CM'];
    ageInYears = json['age_in_years'];
    totalCalories = json['total_calories'];
    massIndex = json['mass_index'];
    dietType = json['diet_type'];
    waterAmount = json['water_amount'];
  }

 
}

