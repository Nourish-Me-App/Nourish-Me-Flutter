import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/api/end_points.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_border_button.dart';
import 'package:nourish_me/feature/forgetpassword/data/repo/forget_password_repo.dart';
import '../../../../core/errors/messages/auth_error_messages.dart';

import 'package:nourish_me/feature/forgetpassword/logic/forget_password_cubit.dart';
import 'package:nourish_me/feature/forgetpassword/view/screens/verfication_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgetPasswordCubit = context.read<ForgetPasswordCubit>();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailure) {
         // Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, AuthErrorMessages.authErrorMessage(state.error!));
        }
        if (state is ForgetPasswordLoading) {
          HelperMethods.showAlertDialog(context);
        }
        if (state is ForgetPasswordSuccess) {
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم ارسال رمز التحقق بنجاح');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: forgetPasswordCubit.formKey,
                    child: Column(
                      children: [
                        Text('هل نسيت كلمه المرور ؟',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.cairo18BoldBlack),
                        SizedBox(height: 5.h),
                        Text(
                            'من فضلك قم بإدخال البريد الإلكتروني  المسجل بحسابك   ',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.cairo12RegularBlack),
                        SizedBox(height: 22.h),
                        SvgPicture.asset(Assets.svgsForgotpasswoedscreen),
                        SizedBox(height: 28.h),
                        const TFFLabel(label: 'البريد الإلكتروني'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'ادخل البريد الإلكتروني',
                          kbType: TextInputType.emailAddress,
                          validate: (value) {
                            return ValidationErrorTexts.emailValidation(value);
                          },
                          controller: forgetPasswordCubit.emailController,
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                            buttonText: 'ارسل رمز التحقق',
                            buttonStyle: AppTextStyles.cairo16BoldWhite,
                            buttonAction: () async {
                              if (forgetPasswordCubit.formKey.currentState!
                                  .validate()) {
                                forgetPasswordCubit.forgetPassword(
                                    EndPoints.forgetPassword,
                                    forgetPasswordCubit.emailController.text);
                              }
                            }),
                        SizedBox(height: 10.h),
                        CustomBorderButton(
                          buttonText: 'إلغاء',
                          buttonAction: () {
                            Navigator.pop(context);
                          },
                          buttonStyle: AppTextStyles.cairo16BoldMainColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
