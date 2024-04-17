import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_radio.dart';
import '../../logic/cubit/questions_cubit.dart';

class CardBody extends StatelessWidget {
  final int? questionsNumber, answersNumber;
  final QuestionsCubit questionsCubit;
  final String question;
  final Map<int, dynamic> answer;

  const CardBody({
    super.key,
    required this.questionsNumber,
    required this.questionsCubit,
    required this.answersNumber,
    required this.question,
    required this.answer,
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
          children: List.generate(
            answersNumber!,
            (index) => CustomRadio(
              answer: answer[index]!,
              value: index,
              groupValue: questionsCubit.cardNumber(questionsNumber!),
              onChanged: (val) {
                questionsCubit.onChangedRadioValue(
                  val,
                  questionsNumber!,
                );
                questionsCubit.clearValidation();
                log('${answer[index]}');
              },
            ),
          ),
        ),
      ],
    );
  }
}
