import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/questions_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../logic/cubit/questions_cubit.dart';
import '../../logic/cubit/questions_ui_cubit.dart';
import 'question_card_body.dart';

class QuestionCard extends StatelessWidget {
  final int? questionsNumber, answersNumber, continueQAnswerNumber;
  final QuestionsUICubit questionsUICubit;
  final String question;
  final List<AnswerOptions>? continueQanswers;
  final String? continueQQuestion;
  final QuestionsCubit questionsCubit;
  final List<AnswerOptions> answers;

  const QuestionCard({
    super.key,
    required this.questionsNumber,
    required this.questionsUICubit,
    required this.answersNumber,
    required this.question,
    required this.answers,
    this.continueQAnswerNumber,
    this.continueQanswers,
    this.continueQQuestion,
    required this.questionsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.currentQuestionColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            CardBody(
              questionsNumber: questionsNumber,
              questionsUICubit: questionsUICubit,
              answersNumber: answersNumber,
              question: question,
              answer: answers,
              questionsCubit: questionsCubit,
            ),
            if (questionsNumber == 0 && questionsUICubit.questionOneValue == 0)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CardBody(
                  questionsNumber: 5,
                  questionsUICubit: questionsUICubit,
                  answersNumber: continueQAnswerNumber,
                  question: continueQQuestion!,
                  answer: continueQanswers!,
                  questionsCubit: questionsCubit,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
