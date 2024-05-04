import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../feature/auth/data/models/login_model.dart';
import '../../feature/auth/logic/cubit/auth_cubit.dart';
import '../routing/routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_constants.dart';
import 'app_images.dart';
import 'cache_helper.dart';

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
      Assets.iconsFacbookFilledBlue,
      Assets.iconsGoogle,
      Assets.svgsAppbarlogo,
      Assets.svgsCilChild,
      Assets.svgsFluentSpatulaSpoon16Regular,
      Assets.svgsFluentMdl2Calories,
      Assets.svgsGuidanceGuestHeightLimit,
      Assets.svgsHomeicon,
      Assets.svgsHomeiconselected,
      Assets.svgsIconParkOutlineWeight,
      Assets.svgsSettings,
      Assets.svgsResultPage,
      Assets.svgsSettingsSelected,
      Assets.svgsTable,
      Assets.svgsTableSelected,
      Assets.svgsType,
      Assets.svgsVector,
      Assets.svgsWaterdrop,
      Assets.svgsWeightSelected,
      Assets.svgsWeightlift,
    ];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
