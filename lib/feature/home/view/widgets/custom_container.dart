import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.svgPath,
    required this.result,
  });

  final String title;
  final Widget svgPath;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.backGroundColorofNavBar,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12.0.w, right: 15.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(result, style: AppTextStyles.cairosemibold14maincolor),
            const Spacer(),
            Text(
              title,
              style: AppTextStyles.cairosemibold14maincolor.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.white,
              child: svgPath,
            ),
          ],
        ),
      ),
    );
  }
}
