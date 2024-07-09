import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/tff_label.dart';

import '../../../../core/widgets/custom_text_form_field.dart';
import '../../logic/cubit/settings_cubit.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  late SettingsCubit settingsCubit;

  @override
  void initState() {
    super.initState();
    settingsCubit = BlocProvider.of<SettingsCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
    settingsCubit.oldPasswordController.dispose();
    settingsCubit.newPasswordController.dispose();
    settingsCubit.newPasswordConfirmationController.dispose();
    settingsCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تغيير كلمة المرور',
          style: AppTextStyles.cairo16BoldWhite.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 48.h),
          child: BlocListener<SettingsCubit, SettingsState>(
            listener: (context, state) {
              if (state is UpdateProfileLoading) {
                HelperMethods.showLoadingAlertDialog(context);
              }
              if (state is UpdateProfileFailed) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                HelperMethods.showCustomSnackBarError(
                    context, ErrorMessages.errorMessage(state.error));
              }
              if (state is UpdateProfileSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                HelperMethods.showCustomSnackBarSuccess(
                    context, 'تم تغيير كلمة المرور بنجاح');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.bottomNavBar,
                  (route) => false,
                );
              }
            },
            listenWhen: (context, state) =>
                state is UpdateProfileFailed ||
                state is UpdateProfileSuccess ||
                state is UpdateProfileLoading,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      const TFFLabel(label: 'كلمة المرور الحالية'),
                      SizedBox(height: 8.h),
                      CustomTFF(
                        hintText: 'ادخل كلمة المرور الحالية',
                        kbType: TextInputType.visiblePassword,
                        controller: settingsCubit.oldPasswordController,
                        validate: (value) {
                          return ValidationErrorTexts.signUpPasswordValidation(
                              value);
                        },
                      ),
                      SizedBox(height: 16.h),
                      const TFFLabel(label: 'كلمة المرور الجديدة'),
                      SizedBox(height: 8.h),
                      CustomTFF(
                        hintText: 'ادخل كلمة المرور الجديدة',
                        kbType: TextInputType.visiblePassword,
                        controller: settingsCubit.newPasswordController,
                        validate: (value) {
                          return ValidationErrorTexts.signUpPasswordValidation(
                              value);
                        },
                      ),
                      SizedBox(height: 16.h),
                      const TFFLabel(label: 'تأكيد كلمة المرور الجديدة'),
                      SizedBox(height: 8.h),
                      CustomTFF(
                        hintText: 'تأكيد كلمة المرور الجديدة',
                        kbType: TextInputType.visiblePassword,
                        controller:
                            settingsCubit.newPasswordConfirmationController,
                        validate: (value) {
                          return ValidationErrorTexts.confirmPasswordValidation(
                              value, settingsCubit.newPasswordController.text);
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomButton(
                        buttonText: 'تغيير',
                        buttonAction: () {
                          if (formKey.currentState!.validate()) {
                            settingsCubit
                                .updateProfile(AppConstants.updateProfile, {
                              'old_password':
                                  settingsCubit.oldPasswordController.text,
                              'password':
                                  settingsCubit.newPasswordController.text,
                              'password_confirmation': settingsCubit
                                  .newPasswordConfirmationController.text,
                            });
                          }
                        },
                        buttonStyle: AppTextStyles.cairo16BoldWhite,
                      ),
                    ],
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
