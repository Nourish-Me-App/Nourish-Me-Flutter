import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networking/api_services.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../models/questions_model.dart';

class QuestionsAndAnswersRepo {
  late ApiServices apiServices;
  QuestionsAndAnswersRepo(
    this.apiServices,
  );

  Future<Either<String, QuestionAndAnswerModel>> getQuestionsAnswers(
      String path, String token) async {
    try {
      var response = await apiServices.get(
        path,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      QuestionAndAnswerModel result = QuestionAndAnswerModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }

  Future<Either<String, String>> postQuestionsAnswers(String path,
      {dynamic data, required String token}) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      String result = response['message'];
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
