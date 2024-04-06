import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_border_button.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/core/widgets/custom_text_form_field.dart';
import 'package:nourish_me/feature/auth/view/widgets/tff_label.dart';

import 'success_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text('إعادة تعييد كلمه المرور ',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.cairo18BoldBlack),
                    SizedBox(height: 40.h),
                    const TFFLabel(label: 'كلمة مرور جديدة'),
                    SizedBox(height: 8.h),
                    const CustomTFF(
                      hintText: 'ادخل كلمة المرور',
                      kbType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 16.h),
                    const TFFLabel(label: 'تأكيد كلمة المرور'),
                    SizedBox(height: 8.h),
                    const CustomTFF(
                      hintText: 'تأكيد كلمة المرور',
                      kbType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 28.h),
                    CustomButton(
                      buttonText: 'تعيين',
                      buttonAction: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccesScreen()),
                                (route) => false);
                      },
                      buttonStyle: AppTextStyles.cairo16BoldWhite,
                    ),
                    SizedBox(height: 16.h),
                    CustomBorderButton(
                        buttonText: 'إلغاء',
                        buttonAction: () {},
                        buttonStyle: AppTextStyles.cairo16BoldMainColor)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}