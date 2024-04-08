import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../theme/app_colors.dart';

final defaultPinTheme = PinTheme(
  width: 58.w,
  height: 58.h,
  textStyle: TextStyle(
      fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(7.r),
    border: Border.all(color: AppColors.otpBackGround, width: 1.w),
    color: AppColors.otpBackGround,
  ),
);
