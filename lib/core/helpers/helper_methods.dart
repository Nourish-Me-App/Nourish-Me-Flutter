import '../imports/login_imports.dart';
import '../theme/app_colors.dart';

class HelperMethods {
  HelperMethods._();
  static void showCustomSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.right,
          style: AppTextStyles.cairo16BoldWhite,
        ),
        backgroundColor: AppColors.tFFErrorColor,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        elevation: 4,
      ),
    );
  }

  static showAlertDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: true,
          child: AlertDialog.adaptive(
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 200.h,
              width: 100.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void afterLogin(
    BuildContext context,
    AuthCubit authCubit,
    LoginModel value,
  ) {
    Navigator.pop(context);
    authCubit.rememberMe
        ? CacheHelper().saveData(
            key: AppConstants.token, value: value.data![AppConstants.token])
        : CacheHelper().removeData(key: AppConstants.token);
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.fakeScreen,
      (route) => false,
    );
  }
}
