import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nourish_me/core/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle cairo20BoldBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cairo18BoldBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo32BoldotpfontColor = GoogleFonts.cairo(
    color: AppColors.otpfontColor,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cairo16SemiBoldBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle cairo16BoldWhite = GoogleFonts.cairo(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo16BoldmainColor = GoogleFonts.cairo(
    color: AppColors.mainColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cairo12SemiBoldBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle cairo12RegularBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle cairo12BoldMainColor = GoogleFonts.cairo(
    color: AppColors.mainColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cairo12ExtraBoldTFFContentColor = GoogleFonts.cairo(
    color: AppColors.tFFContentColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w800,
  );
  static TextStyle cairo12MediumTFFContentColor = GoogleFonts.cairo(
    color: AppColors.tFFContentColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
}
