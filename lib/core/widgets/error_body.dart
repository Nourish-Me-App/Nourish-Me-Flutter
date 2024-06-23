import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/app_images.dart';
import '../theme/app_text_styles.dart';
import 'custom_button.dart';

class ErrorBody extends StatelessWidget {
  final dynamic Function() buttonAction;
  const ErrorBody({super.key, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Assets.imagesServerError,
            height: 340.h,
          ),
          SizedBox(height: 10.h),
          Text(
            'عذرا ، حدث خطأ في الاتصال بالسيرفر',
            style: AppTextStyles.cairo12BoldMainColor.copyWith(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            buttonText: 'إعادة التحميل',
            width: 148.w,
            buttonAction: buttonAction,
            buttonStyle: AppTextStyles.cairo16BoldWhite,
          ),
        ],
      ),
    );
  }
}
