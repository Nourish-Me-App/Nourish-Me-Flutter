import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/helpers/helper_methods.dart';
import 'package:nourish_me/feature/forgot_password/logic/cubit/forgot_password_cubit.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/widgets/pin_put_them.dart';
import '../../logic/check/cubit/check_cubit.dart';
import '../widgets/send_verify_code.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final formKeyotp = GlobalKey<FormState>();
    TextEditingController codeController = TextEditingController();

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordVerifySuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.resetScreen, (route) => false);
        }
        if (state is ForgotPasswordResetFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(context, 'حدث خطأ ما حاول مرة أخرى');
        }
        if (state is ForgotPasswordVerifyLoading) {
          HelperMethods.showAlertDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 60.w),
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
                        email,
                        style: AppTextStyles.cairo12BoldMainColor,
                      ),
                      SvgPicture.asset(Assets.svgsVerify),
                      Form(
                        key: formKeyotp,
                        autovalidateMode: AutovalidateMode.always,
                        child: Pinput(
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل الرمز';
                            }
                            return null;
                          },
                          length: 6,
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
                            BlocProvider.of<CheckCubit>(context)
                                .verifyCode(
                                    email: email, token: codeController.text)
                                .then((value) {
                              Navigator.pushNamed(context, Routes.resetScreen);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      const SendCode(),
                      SizedBox(height: 28.h),
                      CustomButton(
                        buttonText: 'تحقق',
                        buttonAction: () {
                          if (formKeyotp.currentState!.validate()) {
                            BlocProvider.of<CheckCubit>(context)
                                .verifyCode(
                                    email: email, token: codeController.text)
                                .then((value) {
                              Navigator.pushNamed(context, Routes.resetScreen);
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
