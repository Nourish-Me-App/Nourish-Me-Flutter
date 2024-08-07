import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/imports/login_imports.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../data/models/forget_password_model.dart';
import '../../logic/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordCubit forgetPasswordCubit;
  @override
  void initState() {
    forgetPasswordCubit = context.read<ForgetPasswordCubit>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    forgetPasswordCubit.emailController.dispose();
    forgetPasswordCubit.passwordController.dispose();
    forgetPasswordCubit.confirmPasswordController.dispose();
    forgetPasswordCubit.codeController.dispose();
    forgetPasswordCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error!));
        }
        if (state is ForgetPasswordLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
        if (state is ForgetPasswordSuccess) {
          Navigator.pushNamed(context, Routes.verifyEmailScreen);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم ارسال رمز التحقق بنجاح');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
        ),
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
                        SvgPicture.asset(Assets.svgsAuthForgotpasswoedscreen),
                        SizedBox(height: 28.h),
                        const Hero(
                          tag: 'emailLabel',
                          child: Material(
                            color: Colors.transparent,
                            child: TFFLabel(label: 'البريد الإلكتروني'),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'ادخل البريد الإلكتروني',
                          kbType: TextInputType.emailAddress,
                          controller: forgetPasswordCubit.emailController,
                          validate: (value) {
                            return ValidationErrorTexts.emailValidation(value);
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                            buttonText: 'ارسل رمز التحقق',
                            buttonStyle: AppTextStyles.cairo16BoldWhite,
                            buttonAction: () async {
                              if (forgetPasswordCubit.formKey.currentState!
                                  .validate()) {
                                await AuthRequests.forgetPassword(
                                  forgetPasswordCubit: forgetPasswordCubit,
                                  forgetPasswordModel: forgetPasswordModel,
                                  email:
                                      forgetPasswordCubit.emailController.text,
                                ).then((value) {
                                  CacheHelper().saveData(
                                      key: 'email',
                                      value: forgetPasswordCubit
                                          .emailController.text);
                                });
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
