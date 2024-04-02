import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helpers/app_images.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_border_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../view/widgets/tff_label.dart';
import '../../logic/cubit/forgot_password_cubit.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.verifyEmailScreen, (route) => false);
        } else if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: context.read<ForgotPasswordCubit>().formKey,
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
                        CustomTFF(
                          hintText: 'أدخل البريد الإلكتروني',
                          kbType: TextInputType.emailAddress,
                          controller: context
                              .read<ForgotPasswordCubit>()
                              .emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك أدخل كلمة المرور';
                            }
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                          buttonText: 'أرسل رمز التحقق',
                          buttonAction: () async {
                            if (context
                                .read<ForgotPasswordCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              await context
                                  .read<ForgotPasswordCubit>()
                                  .forgetPassword(
                                    email: context
                                        .read<ForgotPasswordCubit>()
                                        .emailController
                                        .text,
                                  )
                                  .then((value) {
                                if (value is ForgotPasswordSuccess) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.verifyEmailScreen,
                                    (route) => false,
                                  );
                                }
                              });
                            }
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
          ),
        );
      },
    );
  }
}
