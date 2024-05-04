import 'package:flutter_svg/flutter_svg.dart';

import '../imports/login_imports.dart';
import '../imports/signup_screen_imports.dart';
import '../theme/app_colors.dart';

class HelperMethods {
  HelperMethods._();
  static void showCustomSnackBarSuccess(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.right,
          style: AppTextStyles.cairo16BoldWhite,
        ),
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        elevation: 4,
      ),
    );
  }

  static void showCustomSnackBarError(BuildContext context, String title) {
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

  static showLoadingAlertDialog(context) {
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
    CacheHelper cacheHelper = CacheHelper();
    Navigator.pop(context);
    authCubit.rememberMe
        ? cacheHelper.saveData(
            key: AppConstants.rememberMeToken,
            value: value.data![AppConstants.token])
        : cacheHelper.removeData(key: AppConstants.rememberMeToken);
    cacheHelper.saveData(
        key: AppConstants.token, value: value.data![AppConstants.token]);
    cacheHelper.saveData(
        key: AppConstants.isFirstQuestionsComplete,
        value: value.data!['user'][AppConstants.isFirstQuestionsComplete]);
    value.data!['user'][AppConstants.isFirstQuestionsComplete] == 'no'
        ? Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.questions,
            (route) => false,
          )
        : Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBar,
            (route) => false,
          );
  }

  static void svgPrecacheImage() {
    const cacheSvgImages = [
      Assets.svgsQuestion,
      Assets.svgsAppLogo,
      Assets.svgsCongratulation,
      Assets.svgsForgotpasswoedscreen,
      Assets.svgsVerify,
      Assets.svgsFemale,
      Assets.svgsMale,
      Assets.svgsOnBoarding1,
      Assets.svgsOnBoarding2,
      Assets.svgsOnBoarding3,
    ];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
