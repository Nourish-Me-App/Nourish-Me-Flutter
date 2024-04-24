import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/imports/app_routes_imports.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/cubit/questions_cubit.dart';
import '../../logic/cubit/questions_ui_cubit.dart';

class MyCheckBox extends StatelessWidget {
  final int index;
  final String answer;
  final String answerId;
  final int questionNumber;
  final QuestionsUICubit questionsUICubit;
  final QuestionsCubit questionsCubit;
  const MyCheckBox({
    super.key,
    required this.answer,
    required this.questionsUICubit,
    required this.questionNumber,
    required this.index,
    required this.answerId,
    required this.questionsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: 46.h,
          child: ListTileTheme(
            horizontalTitleGap: 4.w,
            child: CheckboxListTile.adaptive(
              title: Text(
                answer,
                style: AppTextStyles.cairo16SemiBoldBlack.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: AppColors.mainColor,
              side:
                  const BorderSide(width: 2, color: AppColors.radioBorderColor),
              value: questionsUICubit.questionThreeValue[index],
              onChanged: (value) {
                questionsUICubit.onChangedRadioValue(
                  value: value,
                  questionNum: questionNumber,
                  index: index,
                );
                questionsCubit.setQuestionThreeAnswersList(answerId);
                questionsCubit.answersList();
                questionsUICubit.clearValidation();
              },
            ),
          ),
        ),
      ),
    );
  }
}
