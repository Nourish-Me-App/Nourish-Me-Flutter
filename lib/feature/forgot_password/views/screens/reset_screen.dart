import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/cache_helper.dart';
import 'package:nourish_me/core/helpers/validation_error_texts.dart';
import 'package:nourish_me/feature/forgot_password/logic/cubit/forgot_password_cubit.dart';
import 'package:nourish_me/feature/forgot_password/logic/reset/cubit/reset_cubit.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../auth/view/widgets/tff_label.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyReset = GlobalKey<FormState>();
    //final TextEditingController emailController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController newPasswordConfirmationController =
        TextEditingController();
    return BlocConsumer<ResetCubit, ResetState>(
      listener: (context, state) {
        if (state is ResetSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.loginScreen, (route) => false);
          HelperMethods.showCustomSnackBar(context, 'تم تغير كلمة السر بنجاح ');
        }
        if (state is ResetFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBar(context, 'حدث خطأ ما حاول مرة أخرى');
        }
        if (state is ResetLoading) {
          HelperMethods.showAlertDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: formKeyReset,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Text(
                          'إعادة تعييد كلمة المرور',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.cairo18BoldBlack,
                        ),
                        SizedBox(height: 40.h),
                        // const TFFLabel(label: 'ادخل البريد الإلكتروني'),
                        // SizedBox(height: 8.h),
                        // CustomTFF(
                        //   controller:
                        //       BlocProvider.of<ForgotPasswordCubit>(context)
                        //           .emailController,
                        //   hintText: 'أدخل البريد الإلكتروني',
                        //   kbType: TextInputType.emailAddress,
                        //   validate: (value) {
                        //     ValidationErrorTexts.emailValidation(value);
                        //     return null;
                        //   },
                        // ),
                        SizedBox(height: 8.h),
                        const TFFLabel(label: 'كلمة مرور جديدة'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: newPasswordController,
                          validate: (value) {
                            ValidationErrorTexts.confirmPasswordValidation(
                                value, newPasswordController.text);
                          },
                        ),
                        SizedBox(height: 16.h),
                        const TFFLabel(label: 'تأكيد كلمة المرور'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'تأكيد كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: newPasswordConfirmationController,
                          validate: (value) {
                            ValidationErrorTexts.confirmPasswordValidation(
                                value, newPasswordConfirmationController.text);
                          },
                        ),
                        SizedBox(height: 28.h),
                        CustomButton(
                          buttonText: 'تعيين',
                          buttonAction: () {
                            BlocProvider.of<ResetCubit>(context).resetPassword(
                                email:  CacheHelper().getDataString(key: 'email')!,
                                newpassword: newPasswordController.text,
                                confirmpassword:
                                    newPasswordConfirmationController.text);
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
          ),
        );
      },
    );
  }
}
