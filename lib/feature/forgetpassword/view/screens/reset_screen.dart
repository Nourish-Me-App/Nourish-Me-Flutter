import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/auth_requests.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_border_button.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/core/widgets/custom_text_form_field.dart';
import 'package:nourish_me/feature/auth/view/widgets/tff_label.dart';
import 'package:nourish_me/feature/forgetpassword/logic/forget_password_cubit.dart';

import '../../../../core/errors/messages/auth_error_messages.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/imports/app_routes_imports.dart';
import '../../data/models/reset_password.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ForgetPasswordCubit resetPasswordCubit;

  @override
  void initState() {
    resetPasswordCubit = BlocProvider.of<ForgetPasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    resetPasswordCubit.emailController.dispose();
    resetPasswordCubit.passwordController.dispose();
    resetPasswordCubit.confirmPasswordController.dispose();
    resetPasswordCubit.codeController.dispose();
    resetPasswordCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    ResetPasswordModel resetPasswordModel = ResetPasswordModel();
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, AuthErrorMessages.authErrorMessage(state.error!));
        }
        if (state is ResetPasswordLoading) {
          HelperMethods.showAlertDialog(context);
        }
        if (state is ResetPasswordSuccess) {
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم تعيين كلمه المرور بنجاح');
          Navigator.pushNamed(context, Routes.succesScreen);
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: resetPasswordCubit.formKeyResetPassword,
                child: Column(
                  children: [
                    Text('إعادة تعييد كلمه المرور ',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.cairo18BoldBlack),
                    SizedBox(height: 40.h),
                    const TFFLabel(label: 'كلمة مرور جديدة'),
                    SizedBox(height: 8.h),
                    CustomTFF(
                      hintText: 'ادخل كلمة المرور',
                      kbType: TextInputType.visiblePassword,
                      controller: resetPasswordCubit.passwordController,
                      validate: (value) {
                        return ValidationErrorTexts.signUpPasswordValidation(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    const TFFLabel(label: 'تأكيد كلمة المرور'),
                    SizedBox(height: 8.h),
                    CustomTFF(
                      hintText: 'تأكيد كلمة المرور',
                      kbType: TextInputType.visiblePassword,
                      validate: (value) {
                        return ValidationErrorTexts
                            .confirmPasswordValidation(
                          value,
                          resetPasswordCubit.passwordController.text,
                        );
                      },
                      controller: resetPasswordCubit.confirmPasswordController,
                    ),
                    SizedBox(height: 28.h),
                    CustomButton(
                      buttonText: 'تعيين',
                      buttonAction: () async{
                        if (resetPasswordCubit
                            .formKeyResetPassword.currentState!
                            .validate()) {
                        await  AuthRequests.resetPassword(
                                  forgetPasswordCubit: resetPasswordCubit,
                                  resetPasswordModel: resetPasswordModel,
                                  email: CacheHelper().getData(key: 'email'),
                                  new_password: resetPasswordCubit
                                      .passwordController.text,
                                  new_password_confirmation: resetPasswordCubit
                                      .confirmPasswordController.text)
                              .then((value) {
                            log(
                              "${resetPasswordCubit.passwordController.text}////${resetPasswordCubit.confirmPasswordController.text}",
                            );
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
                        buttonStyle: AppTextStyles.cairo16BoldMainColor)
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}