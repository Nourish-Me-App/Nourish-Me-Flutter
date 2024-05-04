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
      Assets.svgsResultsCilChild,
      Assets.svgsResultsFluentSpatulaSpoon16Regular,
      Assets.svgsResultsFluentMdl2Calories,
      Assets.svgsResultsGuidanceGuestHeightLimit,
      Assets.svgsResultsHomeicon,
      Assets.svgsResultsHomeiconselected,
      Assets.svgsResultsIconParkOutlineWeight,
      Assets.svgsResultsSettings,
      Assets.svgsResultsResultPage,
      Assets.svgsResultsSettingsSelected,
      Assets.svgsResultsTable,
      Assets.svgsResultsTableSelected,
      Assets.svgsResultsType,
      Assets.svgsResultsVector,
      Assets.svgsResultsWaterdrop,
      Assets.svgsResultsWeightSelected,
      Assets.svgsResultsWeightlift,
      Assets.svgsMealsAlmonds,
      Assets.svgsMealsBeans,
      Assets.svgsMealsBlila,
      Assets.svgsMealsBread,
      Assets.svgsMealsBroccoli,
      Assets.svgsMealsBrownToast,
      Assets.svgsMealsCarrotCucumber,
      Assets.svgsMealsChiaSeeds,
      Assets.svgsMealsChicken,
      Assets.svgsMealsChickenBreast,
      Assets.svgsMealsChocolateBar,
      Assets.svgsMealsCoconutCake,
      Assets.svgsMealsCoffee,
      Assets.svgsMealsCookedVegetables,
      Assets.svgsMealsCottageCheese,
      Assets.svgsMealsDate,
      Assets.svgsMealsEgg,
      Assets.svgsMealsEggplant,
      Assets.svgsMealsFasolia,
      Assets.svgsMealsFish,
      Assets.svgsMealsFruits,
      Assets.svgsMealsGreenTea,
      Assets.svgsMealsHumus,
      Assets.svgsMealsJuice,
      Assets.svgsMealsLettuceCucumber,
      Assets.svgsMealsLiver,
      Assets.svgsMealsLobia,
      Assets.svgsMealsLowFatCheese,
      Assets.svgsMealsMashedPotatoes,
      Assets.svgsMealsMeat,
      Assets.svgsMealsMilk,
      Assets.svgsMealsOat,
      Assets.svgsMealsOatBiscuit,
      Assets.svgsMealsOatMilk,
      Assets.svgsMealsOlive,
      Assets.svgsMealsOliveOil,
      Assets.svgsMealsOmelete,
      Assets.svgsMealsPeanutButter,
      Assets.svgsMealsPeas,
      Assets.svgsMealsPepperCucumber,
      Assets.svgsMealsPopcorn,
      Assets.svgsMealsPotato,
      Assets.svgsMealsRice,
      Assets.svgsMealsSalad,
      Assets.svgsMealsShrimp,
      Assets.svgsMealsSingleCarrot,
      Assets.svgsMealsSingleCheese,
      Assets.svgsMealsSinglePepper,
      Assets.svgsMealsSingleTomato,
      Assets.svgsMealsSoup,
      Assets.svgsMealsSpaghetti,
      Assets.svgsMealsSweetPotato,
      Assets.svgsMealsTahina,
      Assets.svgsMealsTomatoPepper,
      Assets.svgsMealsTuna,
      Assets.svgsMealsVegetable,
      Assets.svgsMealsVegetableCheese,
      Assets.svgsMealsWatercress,
      Assets.svgsMealsYogurt,
    ];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
