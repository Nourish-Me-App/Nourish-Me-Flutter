import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/feature/auth/forgot_password/logic/cubit/forgot_password_cubit.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_border_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../view/widgets/tff_label.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordResetSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.succesScreen,
            (route) => false,
          );
        } else if (state is ForgotPasswordResetFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
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
                  child: Form(
                    key: context.read<ForgotPasswordCubit>().formKeyReset,
                    child: Column(
                      children: [
                        Text(
                          'إعادة تعييد كلمة المرور',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.cairo18BoldBlack,
                        ),
                        SizedBox(height: 40.h),
                        const TFFLabel(label: 'ادخل البريد الإلكتروني'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل البريد الإلكتروني',
                          kbType: TextInputType.emailAddress,
                          controller: context
                              .read<ForgotPasswordCubit>()
                              .emailResetController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل البريد الإلكتروني';
                            }
                          },
                        ),
                        SizedBox(height: 8.h),
                        const TFFLabel(label: 'كلمة مرور جديدة'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: context
                              .read<ForgotPasswordCubit>()
                              .newPasswordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل كلمة المرور';
                            }
                          },
                        ),
                        SizedBox(height: 16.h),
                        const TFFLabel(label: 'تأكيد كلمة المرور'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'تأكيد كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: context
                              .read<ForgotPasswordCubit>()
                              .newPasswordConfirmationController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل كلمة المرور';
                            }
                          },
                        ),
                        SizedBox(height: 28.h),
                        CustomButton(
                          buttonText: 'تعيين',
                          buttonAction: () {
                            context.read<ForgotPasswordCubit>().resetPassword(
                                  email: context
                                      .read<ForgotPasswordCubit>()
                                      .emailResetController
                                      .text,
                                  new_password: context
                                      .read<ForgotPasswordCubit>()
                                      .newPasswordController
                                      .text,
                                  new_password_confirmation: context
                                      .read<ForgotPasswordCubit>()
                                      .newPasswordConfirmationController
                                      .text,
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
          ),
        );
      },
    );
  }
}
