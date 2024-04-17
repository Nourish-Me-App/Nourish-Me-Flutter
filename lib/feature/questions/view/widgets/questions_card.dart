import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../logic/cubit/questions_cubit.dart';
import 'question_card_body.dart';

class QuestionCard extends StatelessWidget {
  final int? questionsNumber, answersNumber;
  final QuestionsCubit questionsCubit;
  final String question;
  final Map<int, dynamic> answers;

  const QuestionCard({
    super.key,
    required this.questionsNumber,
    required this.questionsCubit,
    required this.answersNumber,
    required this.question,
    required this.answers,
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
              questionsCubit: questionsCubit,
              answersNumber: answersNumber,
              question: question,
              answer: answers,
            ),
            if (questionsNumber == 0 && questionsCubit.questionOneValue == 0)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CardBody(
                  questionsNumber: 5,
                  questionsCubit: questionsCubit,
                  answersNumber: 3,
                  question: 'كم عدد الأيام التي تمارس فيها الرياضة ؟',
                  answer: const {
                    0: 'من 1:3 أيام في الأسبوع',
                    1: 'من 3:5 أيام في الأسبوع',
                    2: 'من 7:6 أيام في الأسبوع',
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
