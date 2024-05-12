import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/tff_label.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تغيير كلمة المرور',
          style: AppTextStyles.cairo16BoldWhite.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 48.h),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    const TFFLabel(label: 'كلمة المرور الحالية'),
                    SizedBox(height: 8.h),
                    CustomTFF(
                      hintText: 'ادخل كلمة المرور الحالية',
                      kbType: TextInputType.visiblePassword,
                      validate: (value) {
                        return ValidationErrorTexts.signUpPasswordValidation(
                            value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    const TFFLabel(label: 'كلمة المرور الجديدة'),
                    SizedBox(height: 8.h),
                    CustomTFF(
                      hintText: 'ادخل كلمة المرور الجديدة',
                      kbType: TextInputType.visiblePassword,
                      validate: (value) {
                        return ValidationErrorTexts.signUpPasswordValidation(
                            value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    const TFFLabel(label: 'تأكيد كلمة المرور الجديدة'),
                    SizedBox(height: 8.h),
                    CustomTFF(
                      hintText: 'تأكيد كلمة المرور الجديدة',
                      kbType: TextInputType.visiblePassword,
                      validate: (value) {
                        //Todo change validation.
                        return ValidationErrorTexts.confirmPasswordValidation(
                            value, value);
                      },
                    ),
                    SizedBox(height: 40.h),
                    CustomButton(
                      buttonText: 'تغيير',
                      buttonAction: () {
                        if (formKey.currentState!.validate()) {
                          //Todo change password logic with api.
                        }
                      },
                      buttonStyle: AppTextStyles.cairo16BoldWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
