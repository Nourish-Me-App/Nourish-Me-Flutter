import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_border_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../widgets/tff_label.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

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
                    'إعادة تعييد كلمة المرور',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.cairo18BoldBlack,
                  ),
                  SizedBox(height: 40.h),
                  const TFFLabel(label: 'كلمة مرور جديدة'),
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
                  SizedBox(height: 28.h),
                  CustomButton(
                    buttonText: 'تعيين',
                    buttonAction: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.succesScreen,
                        (route) => false,
                      );
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
