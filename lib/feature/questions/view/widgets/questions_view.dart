import 'package:flutter/material.dart';
import '../../data/models/questions_model.dart';
import '../../logic/cubit/questions_cubit.dart';
import 'questions_card.dart';

import '../../logic/cubit/questions_ui_cubit.dart';

class QuestionsView extends StatelessWidget {
  final QuestionsUICubit questionsUICubit;
  final QuestionAndAnswerModel questionsAndAnswersModel;
  final QuestionsCubit questionsCubit;
  final String? loginType;

  const QuestionsView({
    super.key,
    required this.questionsUICubit,
    required this.questionsAndAnswersModel,
    required this.questionsCubit,
    this.loginType,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Easing.legacy,
      switchOutCurve: Easing.legacy,
      duration: const Duration(milliseconds: 500),
      child: returnCard(
        questionsUICubit.questionNumber.toInt(),
      ),
    );
  }

  QuestionCard returnCard(int question) {
    int questionNumber = questionsUICubit.questionNumber.toInt();
    List<Questions> questions = questionsAndAnswersModel.data!.questions!;
    return QuestionCard(
      loginType: loginType,
      key: ValueKey<int>(questionNumber),
      answers: questionNumber != 0
          ? questions[question + 1].answerOptions!
          : questions[question].answerOptions!,
      questionsNumber: question,
      questionsUICubit: questionsUICubit,
      answersNumber: questionNumber != 0
          ? questions[question + 1].answerOptions!.length
          : questions[question].answerOptions!.length,
      question: questionNumber != 0
          ? questions[question + 1].question!
          : questions[question].question!,
      continueQAnswerNumber: questions[question + 1].answerOptions!.length,
      continueQQuestion: questions[question + 1].question!,
      continueQanswers: questions[question + 1].answerOptions!,
      questionsCubit: questionsCubit,
    );
  }
}
