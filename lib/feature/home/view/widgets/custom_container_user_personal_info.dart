import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class CustomContainerUserInfo extends StatelessWidget {
  const CustomContainerUserInfo({
    super.key,
    required this.titleOne,
    required this.titleTwo,
    required this.titleThree,
    required this.svgPathOne,
    required this.svgPathTwo,
    required this.svgPathThree,
  });
  final String titleOne;
  final String titleTwo;
  final String titleThree;
  final Widget svgPathOne;
  final Widget svgPathTwo;
  final Widget svgPathThree;

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
        padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.white,
              child: svgPathThree,
            ),
            SizedBox(width: 5.w),
            Text(
              titleThree,
              style: AppTextStyles.cairo18BoldBlack.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainColor,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.white,
              child: svgPathTwo,
            ),
            SizedBox(width: 5.w),
            Text(
              titleTwo,
              style: AppTextStyles.cairo16BoldMainColor.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.white,
              child: svgPathOne,
            ),
            SizedBox(width: 5.w),
            Text(
              titleOne,
              style: AppTextStyles.cairo16BoldMainColor.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
