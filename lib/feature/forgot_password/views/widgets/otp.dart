import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        height: 58.h,
        width: 58.w,
        child: TextFormField(
          cursorColor: const Color(0xff747474),
          style: AppTextStyles.cairo32BoldOtpFontColor,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            fillColor: AppColors.otpBackGround,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 58.h),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
            ),
          ),
        ),
      ),
    );
  }
}
