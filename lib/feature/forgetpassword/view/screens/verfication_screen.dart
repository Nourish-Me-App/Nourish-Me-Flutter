import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/errors/messages/validation_error_messages.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/helpers/auth_requests.dart';
import 'package:nourish_me/core/helpers/cache_helper.dart';
import 'package:nourish_me/core/helpers/helper_methods.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_border_button.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/feature/forgetpassword/logic/forget_password_cubit.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/errors/messages/auth_error_messages.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/pin_put_them.dart';
import '../../data/models/check_code_model.dart';
import '../widgets/timer.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late ForgetPasswordCubit checkCode;

  @override
  void initState() {
    checkCode = BlocProvider.of<ForgetPasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    checkCode.emailController.dispose();
    checkCode.passwordController.dispose();
    checkCode.confirmPasswordController.dispose();
    checkCode.codeController.dispose();
    checkCode.close();
  }

  @override
  Widget build(BuildContext context) {
    CheckCodeModel checkCodeModel = CheckCodeModel();
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is CheckCodeFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, AuthErrorMessages.authErrorMessage(state.error!));
        }
        if (state is CheckCodeSuccess) {
          Navigator.pushNamed(
            context,
            Routes.resetScreen,
          );
          HelperMethods.showCustomSnackBarSuccess(context, 'تم التحقق بنجاح');
        }
        if (state is CheckCodeLoading) {
          HelperMethods.showAlertDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('رمز التحقق ',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.cairo18BoldBlack),
                      SizedBox(height: 5.h),
                      Text('من فضلك ادخل الكود الذي تم ارساله اليك علي البريد الالكتروني ',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.cairo12RegularBlack),
                      SizedBox(height: 5.h),
                      Text(
                        '${CacheHelper().getData(key: 'email')}',
                        style: AppTextStyles.cairo12BoldMainColor,
                      ),
                      SvgPicture.asset(Assets.svgsVerify),
                      Form(
                        key: checkCode.formKeyCode,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            controller: checkCode.codeController,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                ValidationErrorTexts.otpValidation(value),
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
                                color: AppColors.otpBackGround,
                              ),
                            ),
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) async {
                              log('Completed: $pin');
                              await AuthRequests.checkCode(
                                  forgetPasswordCubit: checkCode,
                                  checkCodeModel: checkCodeModel,
                                  email: CacheHelper().getData(key: 'email'),
                                  token: checkCode.codeController.text);
                            },
                          ),
                        ),
                      ),
                      TimerCode(),
                      SizedBox(height: 28.h),
                      CustomButton(
                        buttonText: 'تحقق',
                        buttonAction: () async {
                          if (checkCode.formKeyCode.currentState!.validate()) {
                            await AuthRequests.checkCode(
                                forgetPasswordCubit: checkCode,
                                checkCodeModel: checkCodeModel,
                                email: CacheHelper().getData(key: 'email'),
                                token: checkCode.codeController.text);
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