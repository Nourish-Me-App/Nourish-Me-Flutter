import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/feature/forgot_password/data/repositories/check_code.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/imports/app_routes_imports.dart';
import '../../../../core/imports/signup_screen_imports.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../logic/check/cubit/check_cubit.dart';
import '../../logic/cubit/forgot_password_cubit.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgetCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم إرسال رمز التحقق بنجاح');
        }
        if (state is ForgotPasswordFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, 'حدث خطأ ما حاول مرة أخرى');
        }
        if (state is ForgotPasswordLoading) {
          HelperMethods.showAlertDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: forgetCubit.formKey,
                    child: Column(
                      children: [
                        Text(
                          'هل نسيت كلمة المرور ؟',
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
                        SizedBox(height: 22.h),
                        SvgPicture.asset(Assets.svgsForgotpasswoedscreen),
                        SizedBox(height: 28.h),
                        const TFFLabel(label: 'البريد الإلكتروني'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل البريد الإلكتروني',
                          kbType: TextInputType.emailAddress,
                          controller: forgetCubit.emailController,
                          validate: (value) {
                            return ValidationErrorTexts.emailValidation(value);
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                          buttonText: 'أرسل رمز التحقق',
                          buttonAction: () async {
                            if (forgetCubit.formKey.currentState!.validate()) {
                              await forgetCubit.forgetPassword().then((value) =>
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<
                                                          ForgotPasswordCubit>.value(
                                                      value: forgetCubit),
                                                  BlocProvider<
                                                          CheckCubit>.value(
                                                      value: CheckCubit(
                                                          CheckCodeRepository()))
                                                ],
                                                child: VerifyEmailScreen(
                                                  email: forgetCubit
                                                      .emailController.text,
                                                ),
                                              ))));
                              CacheHelper.sharedPreferences.setString(
                                  'email', forgetCubit.emailController.text);
                            }
                          },
                          buttonStyle: AppTextStyles.cairo16BoldWhite,
                        ),
                        SizedBox(height: 10.h),
                        CustomBorderButton(
                          buttonText: 'إلغاء',
                          buttonAction: () => Navigator.pop(context),
                          buttonStyle: AppTextStyles.cairo16BoldMainColor,
                        ),
                      ],
                    ),
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
