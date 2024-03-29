import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../auth/view/widgets/tff_label.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'هل نسيت كلمة المرور ؟',
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
                  SizedBox(height: 22.h),
                  SvgPicture.asset(Assets.forgotPassword),
                  SizedBox(height: 28.h),
                  const TFFLabel(label: 'البريد الإلكتروني'),
                  SizedBox(height: 8.h),
                  const CustomTFF(
                    hintText: 'أدخل البريد الإلكتروني',
                    kbType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    buttonText: 'أرسل رمز التحقق',
                    buttonAction: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.verifyEmailScreen,
                        (route) => false,
                      );
                    },
                    buttonStyle: AppTextStyles.cairo16BoldWhite,
                  ),
                  SizedBox(height: 10.h),
                  CustomBorderButton(
                    buttonText: 'إلغاء',
                    buttonAction: () => Navigator.pop(context),
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
