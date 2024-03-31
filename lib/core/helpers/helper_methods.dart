import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

void showCustomSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.right,
        style: AppTextStyles.cairo16BoldWhite,
      ),
      backgroundColor: AppColors.mainColor,
      duration: const Duration(seconds: 3),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      elevation: 4,
    ),
  );
}

showAlertDialog(context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.mainColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 200.h,
        width: 100.w,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
