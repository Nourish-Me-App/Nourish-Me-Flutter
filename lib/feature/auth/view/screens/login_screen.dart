import '../../../../core/imports/verification_screen_imports.dart';

import '../../../../core/imports/login_imports.dart';
import '../../../../core/imports/signup_screen_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    LoginModel loginModel = LoginModel();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          HelperMethods.showCustomSnackBarError(
            context,
            ErrorMessages.errorMessage(state.error!),
          );
        }
        if (state is LoginLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
        if (state is LoginSuccess) {
          AuthRequests.afterLogin(context, authCubit, state.loginModel!);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 50.h),
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
                    SizedBox(height: 16.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'login',
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'تسجيل الدخول',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.cairo20BoldBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.h),
                              const Hero(
                                tag: 'emailLabel',
                                child: Material(
                                  color: Colors.transparent,
                                  child: TFFLabel(label: 'البريد الإلكتروني'),
                                ),
                              ),
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
                                      .loginPasswordValidation(
                                    value,
                                  );
                                },
                              ),
                              SizedBox(height: 8.h),
                              const ForgotAndRememberMeRow(),
                              SizedBox(height: 24.h),
                              Hero(
                                tag: 'authButton',
                                child: CustomButton(
                                  buttonText: 'تسجيل الدخول',
                                  buttonAction: () async {
                                    if (formKey.currentState!.validate()) {
                                      await AuthRequests.login(
                                        authCubit: authCubit,
                                        loginModel: loginModel,
                                        email: authCubit.emailController.text,
                                        password:
                                            authCubit.passwordController.text,
                                        rememberMe: authCubit.rememberMe,
                                      );
                                    }
                                  },
                                  buttonStyle: AppTextStyles.cairo16BoldWhite,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              const AuthContinueQuestion(
                                label: 'ليس لديك حساب ؟  ',
                                action: 'انشئ حساب جديد',
                                route: Routes.signUpScreen,
                              ),
                              SizedBox(height: 16.h),
                              SocialIntegration(
                                integrateWithGoogle: () {},
                              ),
                              SizedBox(height: 16.h),
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
