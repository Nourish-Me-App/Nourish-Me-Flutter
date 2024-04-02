import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/feature/auth/forgot_password/logic/cubit/forgot_password_cubit.dart';
import '../../../../../core/helpers/app_images.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_border_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import '../../../../../core/widgets/pin_put_them.dart';
import '../widgets/send_verify_code.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordVerifySuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.resetScreen,
            (route) => false,
          );
        } else if (state is ForgotPasswordVerifyFailure) {
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
                        'رمز التحقق',
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
                      SizedBox(height: 5.h),
                      Text(
                        'manarGehad@gmail.com',
                        style: AppTextStyles.cairo12BoldMainColor,
                      ),
                      SvgPicture.asset(Assets.verifyEmail),
                      // const OtpRow(),
                      Form(
                        key: context.read<ForgotPasswordCubit>().formKeyOtp,
                        child: Pinput(
                          controller: context
                              .read<ForgotPasswordCubit>()
                              .codeController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل الرمز';
                            }
                            return null;
                          },
                          length: 4,
                          obscuringCharacter: '•',
                          defaultPinTheme: defaultPinTheme,
                          autofocus: true,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration?.copyWith(
                              border: Border.all(
                                color: AppColors.otpBackGround,
                                width: 3,
                              ),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration?.copyWith(
                              color: const Color.fromRGBO(234, 239, 243, 1),
                            ),
                          ),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) {
                            log('Completed: $pin');
                            context.read<ForgotPasswordCubit>().verifyCode(
                                email: context
                                    .read<ForgotPasswordCubit>()
                                    .emailController
                                    .text,
                                token: context
                                    .read<ForgotPasswordCubit>()
                                    .codeController
                                    .text);
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      const SendCode(),
                      SizedBox(height: 28.h),
                      CustomButton(
                        buttonText: 'تحقق',
                        buttonAction: () {
                          if (context
                              .read<ForgotPasswordCubit>()
                              .formKeyOtp
                              .currentState!
                              .validate()) {
                            context
                                .read<ForgotPasswordCubit>()
                                .verifyCode(
                                    email: context
                                        .read<ForgotPasswordCubit>()
                                        .emailController
                                        .text,
                                    token: context
                                        .read<ForgotPasswordCubit>()
                                        .codeController
                                        .text)
                                .then((value) {
                              if (value is ForgotPasswordVerifySuccess) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.resetScreen,
                                  (route) => false,
                                );
                              }
                            });
                          }
                        },
                        buttonStyle: AppTextStyles.cairo16BoldWhite,
                      ),
                      SizedBox(height: 16.h),
                      CustomBorderButton(
                        buttonText: 'إلغاء',
                        buttonAction: () {
                          Navigator.pushNamed(context, Routes.loginScreen);
                        },
                        buttonStyle: AppTextStyles.cairo16BoldMainColor,
                      ),
                    ],
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
