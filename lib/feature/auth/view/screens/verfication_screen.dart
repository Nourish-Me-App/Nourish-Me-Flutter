import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_border_button.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/feature/auth/view/screens/reset_screen.dart';
import 'package:nourish_me/feature/auth/view/widgets/otp.dart';

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
                Text('رمز التحقق ',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.cairo18BoldBlack),
                SizedBox(height: 5.h),
                Text('من فضلك قم بإدخال البريد الإلكتروني  المسجل بحسابك   ',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.cairo12RegularBlack),
                SizedBox(height: 5.h),
                Text(
                  'manarGehad@gmail.com',
                  style: AppTextStyles.cairo12BoldMainColor,
                ),
                SvgPicture.asset(Assets.verifyEmail),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Otp(), Otp(), Otp(), Otp()],
                ),
                SizedBox(height: 16.h),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لم تصلك الرسالة؟',
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetScreen()),
                        (route) => false);
                  },
                  buttonStyle: AppTextStyles.cairo16BoldWhite,
                ),
                SizedBox(height: 16.h),
                CustomBorderButton(
                    buttonText: 'إلغاء',
                    buttonAction: () {},
                    buttonStyle: AppTextStyles.cairo16BoldmainColor)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
