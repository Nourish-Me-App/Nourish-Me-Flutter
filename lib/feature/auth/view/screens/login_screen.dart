import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/app_constants.dart';
import 'package:nourish_me/feature/auth/data/models/login_model.dart';
import 'package:nourish_me/feature/auth/logic/cubit/auth_cubit.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/auth_continue_question.dart';
import '../widgets/tff_label.dart';

import '../widgets/remember_me.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    LoginModel loginModel = LoginModel();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pop(context);
          showCustomSnackBar(context, 'تم تسجيل الدخول بنجاح');
        }
        if (state is LoginFailure) {
          Navigator.pop(context);
          showCustomSnackBar(context, 'فشل تسجيل الدخول');
        }
        if (state is LoginLoading) {
          showAlertDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 42.w, right: 21.w),
                      child: Image.asset(
                        Assets.imagesNourishMeLogo,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'تسجيل الدخول',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.cairo20BoldBlack,
                    ),
                    SizedBox(height: 32.h),
                    const TFFLabel(label: 'البريد الإلكتروني'),
                    SizedBox(height: 8.h),
                    const CustomTFF(
                      hintText: 'أدخل البريد الإلكتروني',
                      kbType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    const TFFLabel(label: 'كلمة المرور'),
                    SizedBox(height: 8.h),
                    const CustomTFF(
                      hintText: 'أدخل كلمة المرور',
                      kbType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 8.h),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          const RememberMe(),
                          Text(
                            'تذكرني',
                            style: AppTextStyles.cairo12SemiBoldBlack,
                          ),
                          const Spacer(),
                          TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              surfaceTintColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.forgotScreen,
                              );
                            },
                            child: Text(
                              'هل نسيت كلمة السر ؟',
                              style: AppTextStyles.cairo12SemiBoldBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      buttonText: 'تسجيل الدخول',
                      buttonAction: () async {
                        var res = await authCubit.login(
                          AppConstants.login,
                          loginModel.toJson(
                            LoginModel(
                              email: 'test4@gmail.com',
                              password: '12345678',
                              rememberMe: true,
                            ),
                          ),
                        );
                        log('${res.data}');
                      },
                      buttonStyle: AppTextStyles.cairo16BoldWhite,
                    ),
                    SizedBox(height: 16.h),
                    const AuthContinueQuestion(
                      label: 'ليس لديك حساب ؟  ',
                      action: 'انشئ حساب جديد',
                      route: Routes.signUpScreen,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
