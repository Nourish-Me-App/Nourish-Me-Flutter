import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_border_button.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/feature/forgetpassword/logic/forget_password_cubit.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/errors/messages/auth_error_messages.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/pin_put_them.dart';
import 'reset_screen.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final verify = BlocProvider.of<ForgetPasswordCubit>(context);
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarSuccess(
              context, AuthErrorMessages.authErrorMessage(state.error!));
        }
        if (state is ForgetPasswordLoading) {
          Navigator.pop(context);
          HelperMethods.showAlertDialog(context);
        }
        if (state is ForgetPasswordSuccess) {
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم ارسال رمز التحقق بنجاح');

        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text('رمز التحقق ',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.cairo18BoldBlack),
                          SizedBox(height: 5.h),
                          Text(
                              'من فضلك قم بإدخال البريد الإلكتروني  المسجل بحسابك   ',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.cairo12RegularBlack),
                          SizedBox(height: 5.h),
                          Text(
                            email,
                            style: AppTextStyles.cairo12BoldMainColor,
                          ),
                          SvgPicture.asset(Assets.svgsVerify),
                          Form(
                            key: verify.formKeyCode,
                            child: Pinput(
                              //textInputAction: TextInputAction.done,
                              controller: verify.codeController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                ValidationErrorTexts.otpValidation(value);
                                return null;
                              },
                              length: 6,
                              obscuringCharacter: '•',
                              defaultPinTheme: defaultPinTheme,
                              autofocus: true,
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration
                                    ?.copyWith(
                                  border: Border.all(
                                    color: AppColors.otpBackGround,
                                    width: 3,
                                  ),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration
                                    ?.copyWith(
                                  color: const Color.fromRGBO(234, 239, 243, 1),
                                ),
                              ),
                              pinputAutovalidateMode: PinputAutovalidateMode
                                  .onSubmit,
                              showCursor: true,
                              onCompleted: (pin) {
                                log('Completed: $pin');
                                // verify.verifyCode(email: email,
                                //     token: verify.codeController.text);
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 100.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'لم تصلك الرسالة؟',
                                    style: AppTextStyles.cairo12RegularBlack,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '(00:15)',
                                    style: AppTextStyles.cairo12BoldMainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 28.h),
                          CustomButton(
                            buttonText: 'تحقق',
                            buttonAction: () {
                             // if(verify.formKeyCode.currentState!.validate()){
                             //   verify.verifyCode(email: email, token: verify.codeController.text).then((value){
                             //     return Navigator.pushNamed(context, Routes.resetScreen);
                             //   });
                             // }
                            },
                            buttonStyle: AppTextStyles.cairo16BoldWhite,
                          ),
                          SizedBox(height: 16.h),
                          CustomBorderButton(
                              buttonText: 'إلغاء',
                              buttonAction: () {
                                Navigator.pushNamed(
                                    context, Routes.loginScreen);
                              },
                              buttonStyle: AppTextStyles.cairo16BoldMainColor)
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}