import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

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
              Center(
                child: SvgPicture.asset(Assets.svgsCongratulation),
              ),
              SizedBox(height: 16.h),
              Text(
                'لقد تم اعادة تعيين كلمة المرور بنجاح يمكنك الأن إعادة تسجيل الدخول',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: AppTextStyles.cairo18BoldBlack,
              ),
              SizedBox(
                height: 32.h,
              ),
              CustomButton(
                buttonText: 'تسجيل الدخول',
                buttonAction: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.loginScreen,
                    (route) => false,
                  );
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
