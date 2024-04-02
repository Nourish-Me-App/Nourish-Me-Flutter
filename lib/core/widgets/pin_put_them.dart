import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 56.w,
  height: 56.h,
  textStyle: TextStyle(
      fontSize: 20.sp,
      color: AppColors.otpFontColor,
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    border: Border.all(color: AppColors.otpBackGround, width: 1.w),
    color: AppColors.otpBackGround,
  ),
);
