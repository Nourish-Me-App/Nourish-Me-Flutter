import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../data/repositories/questions_answers_repo.dart';

import '../../data/models/questions_model.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  late QuestionsAndAnswersRepo questionsAndAnswersRepo;
  QuestionsCubit(this.questionsAndAnswersRepo) : super(QuestionsInitial());
  String? answerOne,
      answerTwo,
      answerThree,
      answerFour,
      answerFive,
      continueAnswerOne;
  List<Map<String, dynamic>> answers = [];
  List<String> questionThreeAnswersList = [];

  void answersList() {
    continueAnswerOne == null
        ? answers = [
            {"question_title": "Sport", "answer_id": "$answerOne"},
            {"question_title": "Sleep Hours", "answer_id": "$answerTwo"},
            {
              "question_title": "Disease",
              "answer_id": [answerThree, ...questionThreeAnswersList]
            },
            {"question_title": "Water Amount", "answer_id": "$answerFour"},
            {"question_title": "Goal", "answer_id": "$answerFive"}
          ]
        : answers = [
            {"question_title": "Sport", "answer_id": "$answerOne"},
            {"question_title": "Sport Days", "answer_id": "$continueAnswerOne"},
            {"question_title": "Sleep Hours", "answer_id": "$answerTwo"},
            {
              "question_title": "Disease",
              "answer_id": [
                'eyJpdiI6InM2aVcwU0FWZEQxMmUrT09pakVYT3c9PSIsInZhbHVlIjoiR3NZcWcvZDR4WWQ4RVZ3RnpwbU1yUT09IiwibWFjIjoiOTIwNTBlMmJjZjBkOGY3MWQyMzc0YTM5OWMwMjIwN2Q0YTBjODM2NWI1ZmRmNGVmYjA5YjA1MWI2NDM1M2Y2NSIsInRhZyI6IiJ9'
              ]
            },
            {"question_title": "Water Amount", "answer_id": "$answerFour"},
            {"question_title": "Goal", "answer_id": "$answerFive"}
          ];
    log('$answers');
  }

  void setQuestionThreeAnswersList(String answerId) {
    if (questionThreeAnswersList.contains(answerId)) {
      questionThreeAnswersList.remove(answerId);
    } else {
      questionThreeAnswersList.add(answerId);
    }
    log('$questionThreeAnswersList');
  }

  void resetQuestionThreeAnswersList() {
    questionThreeAnswersList = [];
  }

  void answerValue(int? questionNumber, dynamic value) {
    switch (questionNumber) {
      case 0:
        answerOne = value;
      case 1:
        answerTwo = value;
      case 2:
        answerThree = value;
      case 3:
        answerFour = value;
      case 4:
        answerFive = value;
      case 5:
        continueAnswerOne = value;
    }
  }

  Future<void> fetchQuestionsAnswers(
    String path,
  ) async {
    emit(QuestionsLoadingState());
    var response = await questionsAndAnswersRepo.getQuestionsAnswers(
        path, CacheHelper().getData(key: AppConstants.token));

    response.fold((error) {
      emit(QuestionsFailureState(error));
    }, (questionAndAnswerModel) {
      emit(QuestionsSuccessState(questionAndAnswerModel));
    });
  }

  Future<void> postQuestionsAnswers(
    String path, {
    dynamic data,
  }) async {
    emit(PostQuestionsLoadingState());
    var response = await questionsAndAnswersRepo.postQuestionsAnswers(path,
        data: data, token: CacheHelper().getData(key: AppConstants.token));

    response.fold((error) {
      emit(PostQuestionsFailureState(error));
    }, (message) {
      emit(PostQuestionsSuccessState(message));
    });
  }
}
