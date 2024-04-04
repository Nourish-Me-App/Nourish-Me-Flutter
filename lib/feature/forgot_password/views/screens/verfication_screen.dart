import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/otp.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'رمز التحقق',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.cairo18BoldBlack,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'من فضلك قم بإدخال البريد الإلكتروني المسجل بحسابك',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.cairo12RegularBlack,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'manarGehad@gmail.com',
                    style: AppTextStyles.cairo12BoldMainColor,
                  ),
                  SvgPicture.asset(Assets.svgsVerify),
                  SizedBox(
                    width: 300.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Otp(),
                        SizedBox(width: 16.w),
                        const Otp(),
                        SizedBox(width: 16.w),
                        const Otp(),
                        SizedBox(width: 16.w),
                        const Otp(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 110.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'أعد إرسال الرمز',
                            style: AppTextStyles.cairo12RegularBlack,
                          ),
                          const Spacer(),
                          Text(
                            '(00:15)',
                            style: AppTextStyles.cairo12BoldMainColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  CustomButton(
                    buttonText: 'تحقق',
                    buttonAction: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.resetScreen, (route) => false);
                    },
                    buttonStyle: AppTextStyles.cairo16BoldWhite,
                  ),
                  SizedBox(height: 16.h),
                  CustomBorderButton(
                    buttonText: 'إلغاء',
                    buttonAction: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.loginScreen,
                      (route) => false,
                    ),
                    buttonStyle: AppTextStyles.cairo16BoldMainColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
