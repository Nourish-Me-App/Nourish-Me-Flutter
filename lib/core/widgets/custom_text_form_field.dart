import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTFF extends StatefulWidget {
  final String hintText;
  final TextInputType kbType;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final dynamic validate;
  const CustomTFF({
    super.key,
    this.prefixIcon,
    required this.hintText,
    required this.kbType,
    this.controller,
    this.validate,
  });

  @override
  State<CustomTFF> createState() => _CustomTFFState();
}

class _CustomTFFState extends State<CustomTFF> {
  bool showPassword = false;
  String content = '';

  @override
  Widget build(BuildContext context) {
    var borderSide = const BorderSide(
      color: AppColors.tFFEnabledBorderColor,
      width: 1,
    );
    return SizedBox(
      height: 40.h,
      child: TextFormField(
        obscureText: widget.hintText == 'أدخل كلمة المرور' ||
                widget.hintText == 'تأكيد كلمة المرور'
            ? showPassword
                ? false
                : true
            : false,
        obscuringCharacter: '●',
        enabled: true,
        style: AppTextStyles.cairo12ExtraBoldTFFContentColor,
        textAlignVertical: TextAlignVertical.center,
        textDirection: TextDirection.rtl,
        cursorColor: AppColors.tFFContentColor,
        textAlign: content.isEmpty ? TextAlign.right : TextAlign.left,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          setState(() {
            content = value;
          });
        },
        decoration: InputDecoration(
          hintFadeDuration: const Duration(milliseconds: 100),
          prefixIcon: widget.hintText == 'أدخل كلمة المرور' ||
                  widget.hintText == 'تأكيد كلمة المرور'
              ? IconButton(
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.mainColor,
                    size: 20.r,
                  ),
                )
              : widget.prefixIcon,
          prefixIconColor: AppColors.mainColor,
          fillColor: content.isEmpty
              ? AppColors.tFFEmptyColor
              : AppColors.tFFFilledColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: borderSide,
          ),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.r),
          //   borderSide: borderSide,
          // ),
          // focusedErrorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.r),
          //   borderSide: borderSide,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          hintStyle: AppTextStyles.cairo12MediumTFFContentColor,
        ),
      ),
    );
  }
}
