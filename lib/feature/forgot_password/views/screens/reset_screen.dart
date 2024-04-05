
import 'package:nourish_me/core/helpers/cache_helper.dart';
import 'package:nourish_me/feature/forgot_password/logic/reset/cubit/reset_cubit.dart';
import '../../../../core/imports/signup_screen_imports.dart';

import '../../../../core/widgets/custom_border_button.dart';


class ResetScreen extends StatelessWidget {
  const ResetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyReset = GlobalKey<FormState>();
    //final TextEditingController emailController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController newPasswordConfirmationController =
        TextEditingController();
    return BlocConsumer<ResetCubit, ResetState>(
      listener: (context, state) {
        if (state is ResetSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.loginScreen, (route) => false);
          HelperMethods.showCustomSnackBarSuccess(context, 'تم تغير كلمة السر بنجاح ');
        }
        if (state is ResetFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(context, 'حدث خطأ ما حاول مرة أخرى');
        }
        if (state is ResetLoading) {
          HelperMethods.showAlertDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 21.w),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: formKeyReset,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Text(
                          'إعادة تعييد كلمة المرور',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.cairo18BoldBlack,
                        ),
                        SizedBox(height: 40.h),
                        // SizedBox(height: 8.h),
                        const TFFLabel(label: 'كلمة مرور جديدة'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'أدخل كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: newPasswordController,
                          validate: (value) {
                            ValidationErrorTexts.confirmPasswordValidation(
                                value, newPasswordController.text);
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        const TFFLabel(label: 'تأكيد كلمة المرور'),
                        SizedBox(height: 8.h),
                        CustomTFF(
                          hintText: 'تأكيد كلمة المرور',
                          kbType: TextInputType.visiblePassword,
                          controller: newPasswordConfirmationController,
                          validate: (value) {
                            ValidationErrorTexts.confirmPasswordValidation(
                                value, newPasswordConfirmationController.text);
                            return null;
                          },
                        ),
                        SizedBox(height: 28.h),
                        CustomButton(
                          buttonText: 'تعيين',
                          buttonAction: () {
                            BlocProvider.of<ResetCubit>(context).resetPassword(
                                email:  CacheHelper().getDataString(key: 'email')!,
                                newpassword: newPasswordController.text,
                                confirmpassword:
                                    newPasswordConfirmationController.text);
                          },
                          buttonStyle: AppTextStyles.cairo16BoldWhite,
                        ),
                        SizedBox(height: 16.h),
                        CustomBorderButton(
                          buttonText: 'إلغاء',
                          buttonAction: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.loginScreen,
                            (route) => false,
                          ),
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
