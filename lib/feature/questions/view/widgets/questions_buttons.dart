import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../logic/cubit/questions_cubit.dart';
import '../../logic/cubit/questions_ui_cubit.dart';

class QuestionsButtons extends StatelessWidget {
  const QuestionsButtons({
    super.key,
    required this.questionsUICubit,
    required this.questionsCubit,
  });

  final QuestionsUICubit questionsUICubit;
  final QuestionsCubit questionsCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        questionsUICubit.questionNumber != 0
            ? CustomBorderButton(
                buttonAction: () {
                  questionsUICubit.clearValidation();
                  questionsUICubit.checkQuestionNumber('السابق');
                },
                buttonText: 'السابق',
                buttonStyle: AppTextStyles.cairo16BoldMainColor.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                height: 32.h,
                width: 147.w,
              )
            : const SizedBox(),
        const Spacer(),
        CustomButton(
          buttonAction: () async {
            questionsUICubit.checkRadioValue()
                ? null
                : questionsUICubit.questionNumber == 4
                    ? await questionsCubit.postQuestionsAnswers(
                        AppConstants.postQuestions,
                        data: {'answers': questionsCubit.answers},
                      )
                    : questionsUICubit.checkQuestionNumber('التالي');
          },
          buttonText: 'التالي',
          buttonStyle: AppTextStyles.cairo16BoldWhite.copyWith(
            fontWeight: FontWeight.w500,
          ),
          height: 32.h,
          width: 147.w,
        ),
      ],
    );
  }
}
