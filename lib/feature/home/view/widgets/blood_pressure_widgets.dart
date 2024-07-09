import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nourish_me/core/theme/app_colors.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class BloodPressureWidgets extends StatelessWidget {
  const BloodPressureWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backGroundColorofNavBar,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15.r,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(Assets.svgsResultsAdvices),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'نصائح هامة :',
                    style: AppTextStyles.cairosemibold14maincolor.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 2.h,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                '1- النظام الغذائي لا يغني عن الدواء,كما عليك مراقبة ضغطك باستمرار',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Text(
                '2- اذا كانت تعاني من زيادة في الوزن يجب عليك اتباع نظام غذائي مناسب لحالتك الصحيه لخساره الوزن ',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Text(
                '3- لايجب ان يزيد محيط الخصر عن 102 سم للرجال و 88 سم للنساء',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 10.h),
              Text(
                '4- يجب ممارسة التمارين الرياضية بانتظام , وشرب الماء بكميات مناسبة',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Text(
                '5- يجب ان لا تزيد كمية الصوديوم (الملح) عن 2300 ملغم يوميا و يفضل خفضها الي 1500 ملغم , كما يجب ان يكون مصدر الصوديو من المصادر الطبيعة وليس من المكملات ',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Text(
                    '6- يجب ان يحتوي نظامك الغذائي علي البوتاسيوم',
                    style: AppTextStyles.cairo14BoldBlack,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                '7- لا تتناول الوجبات السريعة و المشروبات الغازية لأنها تحتوي علي نسبة عالية من الصوديوم و الدهون ويفضل منعها',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Text(
                '8- لا تتناول الوجبات السريعة و المشروبات الغازية لأنها تحتوي علي نسبة عالية من الصوديوم و الدهون ويفضل منعها',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Text(
                '9- حاول الابتعاد عن اللحوم المصنعة , الدقيق الابيض , السكر الابيض , و المخلل',
                style: AppTextStyles.cairo14BoldBlack,
              ),
              SizedBox(height: 12.h),
              Text(
                '10- تجنب تناول الدهون الضارة , وتناول الدهون الصحية مثل المكسرات / زيت جوز الهند / زيت الزيتون',
                style: AppTextStyles.cairo14BoldBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
