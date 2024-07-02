class WorkOut {
  String? message;
  String? status;
  int? statusCode;
  Data? data;

  WorkOut({this.message, this.status, this.statusCode, this.data});

  WorkOut.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Exercises>? exercises;

  Data({this.exercises});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Exercises'] != null) {
      exercises = <Exercises>[];
      json['Exercises'].forEach((v) {
        exercises!.add(Exercises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (exercises != null) {
      data['Exercises'] = exercises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exercises {
  String? name;
  String? type;
  String? sets;
  String? repeats;
  String? rest;
  String? day;
  String? image;

  Exercises(
      {this.name,
      this.type,
      this.sets,
      this.repeats,
      this.rest,
      this.day,
      this.image});

  Exercises.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    sets = json['sets'];
    repeats = json['repeats'];
    rest = json['rest'];
    day = json['day'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['sets'] = sets;
    data['repeats'] = repeats;
    data['rest'] = rest;
    data['day'] = day;
    data['image'] = image;
    return data;
  }
}