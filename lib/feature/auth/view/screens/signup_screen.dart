import 'package:flutter_svg/svg.dart';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/imports/login_imports.dart';
import '../../data/models/signup_model.dart';
import '../../../../core/imports/signup_screen_imports.dart';
import '../widgets/name_row.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthCubit authCubit;
  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authCubit.emailController.dispose();
    authCubit.passwordController.dispose();
    authCubit.firstNameController.dispose();
    authCubit.lastNameController.dispose();
    authCubit.passwordConfirmationController.dispose();
    authCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    SignUpModel signUpModel = SignUpModel();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarSuccess(
              context, 'معلومات صحيحة يرجى إكمال بقية الحقول');
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.continueRegisterScreen,
            (route) => false,
          );
        }
        if (state is SignUpFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
            context,
            ErrorMessages.errorMessage(state.error!),
          );
        }
        if (state is SignUpLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 102.w),
                      child: SvgPicture.asset(
                        height: 160.h,
                        Assets.svgsAppLogo,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                                  return ValidationErrorTexts.emailValidation(
                                      value);
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
                                controller:
                                    authCubit.passwordConfirmationController,
                                validate: (value) {
                                  return ValidationErrorTexts
                                      .confirmPasswordValidation(
                                    value,
                                    authCubit.passwordController.text,
                                  );
                                },
                              ),
                              SizedBox(height: 24.h),
                              Hero(
                                tag: 'authButton',
                                child: CustomButton(
                                  buttonText: 'أنشئ حساب',
                                  buttonAction: () async {
                                    if (formKey.currentState!.validate()) {
                                      await AuthRequests.signUp(
                                        authCubit: authCubit,
                                        signUpModel: signUpModel,
                                        name:
                                            '${authCubit.firstNameController.text} ${authCubit.lastNameController.text}',
                                        email: authCubit.emailController.text,
                                        password:
                                            authCubit.passwordController.text,
                                        passwordConfirmation: authCubit
                                            .passwordConfirmationController
                                            .text,
                                      );
                                    }
                                  },
                                  buttonStyle: AppTextStyles.cairo16BoldWhite,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              const AuthContinueQuestion(
                                label: 'لديك حساب بالفعل ؟ْ  ',
                                action: 'تسجيل الدخول',
                                route: Routes.loginScreen,
                              ),
                              SizedBox(height: 8.h),
                              SocialIntegration(
                                integrateWithGoogle: () {},
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ),
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
