import 'package:flutter/material.dart';
import 'package:nourish_me/feature/questions/view/widgets/questions_card.dart';

import '../../logic/cubit/questions_cubit.dart';

class QuestionsView extends StatelessWidget {
  final QuestionsCubit questionsCubit;

  const QuestionsView({
    super.key,
    required this.questionsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Easing.legacy,
      switchOutCurve: Easing.legacy,
      duration: const Duration(milliseconds: 500),
      child: returnCard(
        questionsCubit.questionNumber.toInt(),
      ),
    );
  }

  QuestionCard returnCard(int question) {
    return QuestionCard(
      key: ValueKey<int>(questionsCubit.questionNumber.toInt()),
      answers: questionsCubit.questions[question].answers!,
      questionsNumber: question,
      questionsCubit: questionsCubit,
      answersNumber: questionsCubit.questions[question].answers!.length,
      question: questionsCubit.questions[question].question!,
    );
  }
}
