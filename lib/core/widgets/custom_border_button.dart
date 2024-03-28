import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/theme/app_colors.dart';

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({
    super.key,
    required this.buttonText,
    required this.buttonAction,
    required this.buttonStyle,
  });

  final String buttonText;
  final TextStyle buttonStyle;
  final Function() buttonAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: MaterialButton(
        onPressed: buttonAction,
        padding: EdgeInsets.zero,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: AppColors.mainColor,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: buttonStyle,
          ),
        ),
      ),
    );
  }
}
