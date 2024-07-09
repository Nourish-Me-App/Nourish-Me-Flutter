import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nourish_me/core/theme/app_colors.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class BloodSugerWidgets extends StatelessWidget {
  const BloodSugerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 710.h,
      width: 400.w,
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '1- تناول معلقة زيت زيتون بكر كل يوم صباحا',
                    style: AppTextStyles.cairo15BoldBlack,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                '2- تجنب تناول الفواكهة التي تحتوي علي مؤشر جلايسيمي عالي مثل ( الموز / المانجو / البلح / التين /  العنب / التمر/ الفواكه المجففة ) ويمكنك تناول ( التفاح / الشمام / التوت / الفراولة/ البرتقال / الكيوي / الكمثري )',
                style: AppTextStyles.cairo15BoldBlack,
              ),
              SizedBox(height: 15.h),
              Text(
                '3- شرب الماء بكميات كافية والنوم لعدد ساعات كافية أثناء الليل ',
                style: AppTextStyles.cairo15BoldBlack,
              ),
              SizedBox(height: 10.h),
              Text(
                '4- اذا كنت تعاني من زيادة في الوزن , يجب عليك خسارة وزنك الزائد مع ممارسة الرياضة',
                style: AppTextStyles.cairo15BoldBlack,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '5- عدم التدخين',
                    style: AppTextStyles.cairo15BoldBlack,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                '6- الخضوع للكشوفات الطبية وفحص العين علي الاقل مرتين في العام',
                style: AppTextStyles.cairo15BoldBlack,
              ),
              SizedBox(height: 15.h),
              Text(
                '7- انتبه الي قدميك ولا تمشي حاف القدمين وتأكد من سلامة قدمك كل ليلة',
                style: AppTextStyles.cairo15BoldBlack,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '8- انتبه لأسنانك ولا تهمل التهابات اللثة',
                    style: AppTextStyles.cairo15BoldBlack,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                '9- تعرض لأشعة الشمس بشكل يومي علي الاقل نصف ساعة',
                style: AppTextStyles.cairo15BoldBlack,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '10- احرص علي تناول وجبة الافطار وعدم اهمالها',
                    style: AppTextStyles.cairo15BoldBlack,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '11- تجنب الضغط النفسي والقلق',
                    style: AppTextStyles.cairo15BoldBlack,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
