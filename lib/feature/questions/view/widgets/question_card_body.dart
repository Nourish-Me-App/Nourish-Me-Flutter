import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/cache_helper.dart';
import 'custom_check_box.dart';
import '../../data/models/questions_model.dart';
import '../../logic/cubit/questions_cubit.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_radio.dart';
import '../../logic/cubit/questions_ui_cubit.dart';

class CardBody extends StatelessWidget {
  final int? questionsNumber, answersNumber;
  final QuestionsUICubit questionsUICubit;
  final String question;
  final String? loginType;
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
    this.loginType,
  });

  @override
  Widget build(BuildContext context) {
    CacheHelper cacheHelper = CacheHelper();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                question,
                style: AppTextStyles.cairo16SemiBoldBlack,
                textAlign: TextAlign.right,
              ),
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
          children: questionsNumber == 6
              ? List.generate(
                  answersNumber!,
                  (index) => MyCheckBox(
                      answer: answer[index].answer!,
                      questionsUICubit: questionsUICubit,
                      questionNumber: questionsNumber!,
                      index: index,
                      answerId: answer[index].id!,
                      questionsCubit: questionsCubit),
                )
              : List.generate(
                  answersNumber!,
                  (index) => CustomRadio(
                    isDisabled: num.parse(cacheHelper.getData(key: loginType == 'googleLogin' ? 'googleBmi' : 'bmi')) >= 18.5 &&
                            num.parse(cacheHelper.getData(key: loginType == 'googleLogin' ? 'googleBmi' : 'bmi')) <=
                                24.9
                        ? (answer[index].answer == 'زيادة الوزن'
                            ? cacheHelper.getData(key: 'answer') == 'سمنة' ||
                                    cacheHelper.getData(key: 'answer') ==
                                        'لا أعاني'
                                ? true
                                : false
                            : answer[index].answer == 'خسارة الوزن'
                                ? cacheHelper.getData(key: 'answer') == 'نحافة' ||
                                        cacheHelper.getData(key: 'answer') ==
                                            'لا أعاني'
                                    ? true
                                    : false
                                : answer[index].answer == 'ثبات الوزن'
                                    ? cacheHelper.getData(key: 'answer2') ==
                                                'ثبات الوزن' ||
                                            cacheHelper.getData(key: 'answer') ==
                                                'نحافة'
                                        ? true
                                        : false
                                    : false)
                        : (num.parse(cacheHelper.getData(key: loginType == 'googleLogin' ? 'googleBmi' : 'bmi')) <= 18.5 &&
                                (answer[index].answer == 'سمنة' ||
                                    answer[index].answer == 'لا أعاني')
                            ? true
                            : (num.parse(cacheHelper.getData(key: loginType == 'googleLogin' ? 'googleBmi' : 'bmi')) <= 18.5 &&
                                    (answer[index].answer == 'ثبات الوزن' ||
                                        answer[index].answer == 'خسارة الوزن'))
                                ? true
                                : num.parse(cacheHelper.getData(key: loginType == 'googleLogin' ? 'googleBmi' : 'bmi')) >= 24.9 &&
                                        (answer[index].answer == 'نحافة' ||
                                            answer[index].answer == 'لا أعاني')
                                    ? true
                                    : num.parse(cacheHelper.getData(key: loginType == 'googleLogin' ? 'googleBmi' : 'bmi')) >= 24.9
                                        ? (answer[index].answer == 'زيادة الوزن') || (answer[index].answer == 'ثبات الوزن' && cacheHelper.getData(key: 'answer2') == 'ثبات الوزن')
                                            ? true
                                            : false
                                        : false),
                    answer: answer[index].answer!,
                    value: index,
                    groupValue: questionsUICubit.cardNumber(questionsNumber!),
                    onChanged: (val) {
                      questionsUICubit.onChangedValue(
                        value: val,
                        questionNum: questionsNumber!,
                      );

                      questionsUICubit.clearValidation();

                      if (questionsUICubit.questionNumber == 0 &&
                          questionsUICubit.questionOneValue == 1) {
                        questionsCubit.answerValue(5, null);
                      }

                      if (questionsUICubit.questionNumber == 2 &&
                          questionsUICubit.questionThreeValue == 1) {
                        questionsCubit.resetQuestionThreeAnswersList();
                        questionsUICubit.resetContinueQuestionThreeValueList();
                        questionsUICubit.resetContinueQuestionThreeValueList3();
                        questionsCubit.answerValue(4, null);
                        questionsUICubit.resetQuestionFiveValue();
                        cacheHelper.removeData(key: 'answer2');
                      }

                      if (questionsUICubit.questionNumber == 2 &&
                          questionsUICubit.questionThreeValue == 0) {
                        questionsUICubit.resetContinueQuestionThreeValueList2();
                        questionsUICubit.resetContinueQuestionThreeValueList3();
                        questionsCubit.resetQuestionThreeAnswersList();
                        questionsCubit.answerValue(4, null);
                        questionsUICubit.resetQuestionFiveValue();
                      }
                      if (questionsUICubit.questionNumber == 2 &&
                          questionsUICubit.questionThreeValue == 2) {
                        questionsUICubit.resetContinueQuestionThreeValueList();
                        questionsUICubit.resetContinueQuestionThreeValueList2();
                        questionsCubit.resetQuestionThreeAnswersList();
                        questionsCubit.answerValue(4, null);
                        cacheHelper.removeData(key: 'answer2');
                        questionsUICubit.resetQuestionFiveValue();
                      }

                      questionsCubit.answerValue(
                          questionsNumber, answer[index].id!);
                      questionsUICubit.questionNumber == 2
                          ? cacheHelper.saveData(
                              key: 'answer', value: answer[index].answer)
                          : null;
                      questionsCubit.answersList();
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
