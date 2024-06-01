class DietsModel {
  String? message;
  String? status;
  int? statusCode;
  Data? data;

  DietsModel({this.message, this.status, this.statusCode, this.data});

  DietsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Diet? diet;

  Data({this.diet});

  Data.fromJson(Map<String, dynamic> json) {
    diet = json['diet'] != null ? Diet.fromJson(json['diet']) : null;
  }
}

class Diet {
  String? name;
  String? calories;
  String? type;
  Meals? meals;

  Diet({this.name, this.calories, this.type, this.meals});

  Diet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    type = json['type'];
    meals = json['meals'] != null ? Meals.fromJson(json['meals']) : null;
  }
}

class Meals {
  Day? saturday;
  Day? sunday;
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;

  Meals({
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  Meals.fromJson(Map<String, dynamic> json) {
    saturday = json['saturday'] != null ? Day.fromJson(json['saturday']) : null;
    sunday = json['sunday'] != null ? Day.fromJson(json['sunday']) : null;
    monday = json['monday'] != null ? Day.fromJson(json['monday']) : null;
    tuesday = json['tuesday'] != null ? Day.fromJson(json['tuesday']) : null;
    wednesday =
        json['wednesday'] != null ? Day.fromJson(json['wednesday']) : null;
    thursday = json['thursday'] != null ? Day.fromJson(json['thursday']) : null;
    friday = json['friday'] != null ? Day.fromJson(json['friday']) : null;
  }
}

class Day {
  int? id;
  List<String>? breakfast;
  String? firstSnack;
  List<String>? lunch;
  String? secondSnack;
  List<String>? dinner;

  Day({
    this.id,
    this.breakfast,
    this.firstSnack,
    this.lunch,
    this.secondSnack,
    this.dinner,
  });

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breakfast = json['breakfast'].cast<String>();
    firstSnack = json['first_snack'];
    lunch = json['lunch'].cast<String>();
    secondSnack = json['second_snack'];
    dinner = json['dinner'].cast<String>();
  }
}
