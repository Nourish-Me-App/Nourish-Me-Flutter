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
  final String? loginType;
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
    this.loginType,
  });

  @override
  Widget build(BuildContext context) {
    List<AnswerOptions> problems = answers.where(
      (element) {
        return element.answer == 'نحافة' || element.answer == 'سمنة';
      },
    ).toList();
    List<AnswerOptions> problemsOrNot = [
      ...problems,
      AnswerOptions(answer: 'لا أعاني', id: ''),
    ];
    List<AnswerOptions> problemsAndDeseases = answers.where(
      (element) {
        return element.answer != 'نحافة' && element.answer != 'سمنة';
      },
    ).toList();
    List<AnswerOptions> problemsAndDeseases2 = answers.where(
      (element) {
        return element.answer == 'ضغط' || element.answer == 'سكر';
      },
    ).toList();
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
              loginType: loginType,
              questionsNumber: questionsNumber,
              questionsUICubit: questionsUICubit,
              answersNumber:
                  questionsNumber == 2 ? problemsOrNot.length : answersNumber,
              question:
                  questionsNumber == 2 ? 'أي من المشاكل تعاني منها؟' : question,
              answer: questionsNumber == 2 ? problemsOrNot : answers,
              questionsCubit: questionsCubit,
            ),
            if (questionsNumber == 0 && questionsUICubit.questionOneValue == 0)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CardBody(
                  loginType: loginType,
                  questionsNumber: 5,
                  questionsUICubit: questionsUICubit,
                  answersNumber: continueQAnswerNumber,
                  question: continueQQuestion!,
                  answer: continueQanswers!,
                  questionsCubit: questionsCubit,
                ),
              ),
            if (questionsNumber == 2 &&
                questionsUICubit.questionThreeValue == 0)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CardBody(
                  loginType: loginType,
                  questionsNumber: 6,
                  questionsUICubit: questionsUICubit,
                  answersNumber: problemsAndDeseases.length,
                  question:
                      'أي من الامراض تعاني منها (يمكن عدم الاختيار او تحديد اكثر من اختيار)؟',
                  answer: problemsAndDeseases,
                  questionsCubit: questionsCubit,
                ),
              ),
            if (questionsNumber == 2 &&
                questionsUICubit.questionThreeValue == 1)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CardBody(
                  loginType: loginType,
                  questionsNumber: 6,
                  questionsUICubit: questionsUICubit,
                  answersNumber: problemsAndDeseases2.length,
                  question:
                      'أي من الامراض تعاني منها (يمكن عدم الاختيار او تحديد اكثر من اختيار)؟',
                  answer: problemsAndDeseases2,
                  questionsCubit: questionsCubit,
                ),
              ),
            if (questionsNumber == 2 &&
                questionsUICubit.questionThreeValue == 2)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: CardBody(
                  loginType: loginType,
                  questionsNumber: 6,
                  questionsUICubit: questionsUICubit,
                  answersNumber: problemsAndDeseases2.length,
                  question:
                      'أي من الامراض تعاني منها (يمكن عدم الاختيار او تحديد اكثر من اختيار)؟',
                  answer: problemsAndDeseases2,
                  questionsCubit: questionsCubit,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
