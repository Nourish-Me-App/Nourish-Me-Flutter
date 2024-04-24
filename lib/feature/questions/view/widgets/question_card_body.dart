import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/feature/questions/data/models/questions_model.dart';
import 'package:nourish_me/feature/questions/logic/cubit/questions_cubit.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_radio.dart';
import '../../logic/cubit/questions_ui_cubit.dart';
import 'custom_check_box.dart';

class CardBody extends StatelessWidget {
  final int? questionsNumber, answersNumber;
  final QuestionsUICubit questionsUICubit;
  final String question;
  final List<AnswerOptions> answer;
  final QuestionsCubit questionsCubit;

  const CardBody({
    super.key,
    required this.questionsNumber,
    required this.questionsUICubit,
    required this.answersNumber,
    required this.question,
    required this.answer,
    required this.questionsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              question,
              style: AppTextStyles.cairo16SemiBoldBlack,
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 8.w),
            Container(
              width: 8.w,
              height: 8.h,
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Column(
          children: questionsUICubit.questionNumber == 2
              ? List.generate(
                  answersNumber!,
                  (index) => MyCheckBox(
                    index: index,
                    answer: answer[index].answer!,
                    questionsUICubit: questionsUICubit,
                    questionsCubit: questionsCubit,
                    questionNumber: questionsNumber!,
                    answerId: answer[index].id!,
                  ),
                )
              : List.generate(
                  answersNumber!,
                  (index) => CustomRadio(
                    answer: answer[index].answer!,
                    value: index,
                    groupValue: questionsUICubit.cardNumber(questionsNumber!),
                    onChanged: (val) {
                      questionsUICubit.onChangedRadioValue(
                        value: val,
                        questionNum: questionsNumber!,
                      );
                      questionsUICubit.clearValidation();

                      if (questionsUICubit.questionNumber == 0 &&
                          questionsUICubit.questionOneValue == 1) {
                        questionsCubit.answerValue(5, null);
                      }
                      questionsCubit.answerValue(
                          questionsNumber, answer[index].id!);

                      questionsCubit.answersList();
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
