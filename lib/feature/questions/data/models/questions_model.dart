class QuestionAndAnswerModel {
  String? message;
  String? status;
  int? statusCode;
  Data? data;

  QuestionAndAnswerModel(
      {this.message, this.status, this.statusCode, this.data});

  factory QuestionAndAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAndAnswerModel(
      message: json['message'],
      status: json['status'],
      statusCode: json['status_code'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  List<Questions>? questions;

  Data({this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }
}

class Questions {
  String? title;
  String? question;
  List<AnswerOptions>? answerOptions;

  Questions({this.title, this.question, this.answerOptions});

  Questions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    question = json['question'];
    if (json['answer_options'] != null) {
      answerOptions = <AnswerOptions>[];
      json['answer_options'].forEach((v) {
        answerOptions!.add(AnswerOptions.fromJson(v));
      });
    }
  }
}

class AnswerOptions {
  String? id;
  String? answer;

  AnswerOptions({this.id, this.answer});

  AnswerOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
  }
}
