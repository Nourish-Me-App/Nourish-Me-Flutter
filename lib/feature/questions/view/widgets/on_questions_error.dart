import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../logic/cubit/questions_cubit.dart';

class OnQuestionsError extends StatelessWidget {
  const OnQuestionsError({
    super.key,
    required this.questionsCubit,
    required this.title,
  });

  final QuestionsCubit questionsCubit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.r),
            SizedBox(height: 16.h),
            SizedBox(
              width: 250.w,
              child: Text(
                title,
                style: AppTextStyles.cairo20BoldBlack,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              width: 150.w,
              buttonText: 'إعادة تحميل',
              buttonAction: () async {
                await questionsCubit
                    .fetchQuestionsAnswers(AppConstants.questions);
              },
              buttonStyle: AppTextStyles.cairo16BoldWhite,
            ),
          ],
        ),
      ),
    );
  }
}
