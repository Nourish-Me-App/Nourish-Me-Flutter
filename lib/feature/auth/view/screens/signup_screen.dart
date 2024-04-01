import '../../../../core/imports/signup_screen_imports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    SignUpModel signUpModel = SignUpModel();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          HelperMethods.showCustomSnackBar(context, 'تم إنشاء حسابك بنجاح');
        }
        if (state is SignUpFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBar(context, 'فشل إنشاء الحساب');
        }
        if (state is SignUpLoading) {
          HelperMethods.showAlertDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                          'أنشئ حساب جديد',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.cairo20BoldBlack,
                        ),
                        SizedBox(height: 24.h),
                        const NameRow(),
                        SizedBox(height: 16.h),
                        const TFFLabel(label: 'البريد الإلكتروني'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل البريد الإلكتروني',
                          kbType: TextInputType.emailAddress,
                          controller: authCubit.emailController,
                          validate: (value) {
                            return ValidationErrorTexts.emailValidation(value);
                          },
                        ),
                        SizedBox(height: 16.h),
                        const TFFLabel(label: 'كلمة المرور'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: authCubit.passwordController,
                          validate: (value) {
                            return ValidationErrorTexts
                                .signUpPasswordValidation(value);
                          },
                        ),
                        SizedBox(height: 16.h),
                        const TFFLabel(label: 'تأكيد كلمة المرور'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'تأكيد كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: authCubit.passwordConfirmationController,
                          validate: (value) {
                            return ValidationErrorTexts
                                .confirmPasswordValidation(
                              value,
                              authCubit.passwordController.text,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          buttonText: 'أنشئ حساب',
                          buttonAction: () async {
                            if (formKey.currentState!.validate()) {
                              await AuthRequests.signUp(
                                authCubit: authCubit,
                                signUpModel: signUpModel,
                                name:
                                    '${authCubit.firstNameController.text} ${authCubit.lastNameController.text}',
                                email: authCubit.emailController.text,
                                password: authCubit.passwordController.text,
                                passwordConfirmation: authCubit
                                    .passwordConfirmationController.text,
                              ).then(
                                (value) {
                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.loginScreen,
                                    (route) => false,
                                  );
                                },
                              );
                            }
                          },
                          buttonStyle: AppTextStyles.cairo16BoldWhite,
                        ),
                        SizedBox(height: 8.h),
                        const AuthContinueQuestion(
                          label: 'لديك حساب بالفعل ؟ْ  ',
                          action: 'تسجيل الدخول',
                          route: Routes.loginScreen,
                        ),
                        SizedBox(height: 8.h),
                        SocialIntegration(
                          integrateWithFacebook: () {},
                          integrateWithGoogle: () {},
                        ),
                        SizedBox(height: 4.h),
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
