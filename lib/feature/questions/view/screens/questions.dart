import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourish_me/feature/questions/logic/cubit/questions_cubit.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/current_question.dart';
import '../widgets/questions_view.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late QuestionsCubit questionsCubit;

  @override
  void initState() {
    super.initState();
    questionsCubit = BlocProvider.of<QuestionsCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
          child: BlocBuilder<QuestionsCubit, QuestionsState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      'أجب علي الأسئلة التالية',
                      style: AppTextStyles.cairo18BoldBlack
                          .copyWith(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CurrentQuestion(index: questionsCubit.questionNumber.toInt()),
                  SizedBox(height: 28.h),
                  Center(
                    child: SvgPicture.asset(Assets.svgsQuestion),
                  ),
                  SizedBox(height: 20.h),
                  QuestionsView(
                    questionsCubit: questionsCubit,
                  ),
                  questionsCubit.validate()
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            '! يجب اختيار واحد من الاختيارين السابقين',
                            style: AppTextStyles.cairo11MediumTFFErrorColor,
                          ),
                        )
                      : SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      questionsCubit.questionNumber != 0
                          ? CustomBorderButton(
                              buttonAction: () {
                                questionsCubit.clearValidation();
                                questionsCubit.checkQuestionNumber('السابق');
                              },
                              buttonText: 'السابق',
                              buttonStyle:
                                  AppTextStyles.cairo16BoldMainColor.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              height: 32.h,
                              width: 147.w,
                            )
                          : const SizedBox(),
                      const Spacer(),
                      CustomButton(
                        buttonAction: () {
                          questionsCubit.checkRadioValue()
                              ? null
                              : questionsCubit.questionNumber == 4
                                  ? null
                                  : questionsCubit
                                      .checkQuestionNumber('التالي');
                        },
                        buttonText: 'التالي',
                        buttonStyle: AppTextStyles.cairo16BoldWhite.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        height: 32.h,
                        width: 147.w,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
