import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import 'package:nourish_me/core/widgets/custom_text_form_field.dart';
import 'package:nourish_me/feature/auth/view/widgets/auth_continue_question.dart';
import 'package:nourish_me/feature/auth/view/widgets/tff_label.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 42.w, right: 21.w),
                    child: Image.asset(
                      Assets.imagesNourishMeLogo,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'أنشئ حساب جديد',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.cairo20BoldBlack,
                  ),
                  SizedBox(height: 32.h),
                  const TFFLabel(label: 'البريد الإلكتروني'),
                  SizedBox(height: 8.h),
                  const CustomTFF(
                    hintText: 'أدخل البريد الإلكتروني',
                    kbType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  const TFFLabel(label: 'كلمة المرور'),
                  SizedBox(height: 8.h),
                  const CustomTFF(
                    hintText: 'أدخل كلمة المرور',
                    kbType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 16.h),
                  const TFFLabel(label: 'تأكيد كلمة المرور'),
                  SizedBox(height: 8.h),
                  const CustomTFF(
                    hintText: 'تأكيد كلمة المرور',
                    kbType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    buttonText: 'أنشئ حساب',
                    buttonAction: () {},
                    buttonStyle: AppTextStyles.cairo16BoldWhite,
                  ),
                  SizedBox(height: 16.h),
                  const AuthContinueQuestion(
                    label: 'لديك حساب بالفعل ؟ْ  ',
                    action: 'تسجيل الدخول',
                    route: Routes.loginScreen,
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
