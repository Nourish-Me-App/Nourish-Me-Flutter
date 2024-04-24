import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle cairo20BoldBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cairo24Boldmaincolor = GoogleFonts.cairo(
    color: AppColors.mainColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cairosemibold14maincolor = GoogleFonts.cairo(
    color: AppColors.mainColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle cairo18BoldBlack = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo32BoldotpBackGround = GoogleFonts.cairo(
    color: AppColors.otpBackGround,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo700BoldDataScreen = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo15normaltextcolorOnboarding = GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle cairo16boldtextcolorOnboarding = GoogleFonts.cairo(
    color: AppColors.mainColor,
    fontSize: 16.sp,
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

  static TextStyle cairo16BoldMainColor = GoogleFonts.cairo(
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

  static TextStyle cairo12RegularGrey = GoogleFonts.cairo(
    color: Colors.grey,
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
  static TextStyle cairo12RegularTFFErrorColor = GoogleFonts.cairo(
    color: AppColors.tFFErrorColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
}
