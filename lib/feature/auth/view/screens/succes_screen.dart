import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/feature/auth/view/screens/login_screen.dart';

class SuccesScreen extends StatelessWidget {
  const SuccesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 100.w),
          child: Column(
            children: [
              Center(child: SvgPicture.asset(Assets.success)),
              SizedBox(height: 16.h),
              Text(
                  'لقد تم اعاده تعيين كلمه المرور بنجاح يمكنك الان اعاده تسجيل الدخول',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cairo18BoldBlack),
              SizedBox(
                height: 32.h,
              ),
              CustomButton(
                buttonText: 'تسجيل الدخول',
                buttonAction: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                buttonStyle: AppTextStyles.cairo16BoldWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
