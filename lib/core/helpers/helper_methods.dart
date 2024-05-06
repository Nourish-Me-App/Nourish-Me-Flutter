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
      Assets.svgsResultsResults,
      Assets.svgsResultsSettingsSelected,
      Assets.svgsResultsTable,
      Assets.svgsResultsTableSelected,
      Assets.svgsResultsType,
      Assets.svgsResultsVector,
      Assets.svgsResultsWaterdrop,
      Assets.svgsResultsWeightSelected,
      Assets.svgsResultsWeightlift,
    ];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  static String getMealImage(String meal) {
    {
      if (meal.contains('رغيف') ||
          (meal.contains('توست') && meal.contains('رغيف'))) {
        return Assets.imagesMealsBread;
      } else if (meal.contains('توست')) {
        return Assets.imagesMealsBrownToast;
      }
    }
    if (meal.contains('تمر')) {
      return Assets.imagesMealsDate;
    }
    if (meal.contains('فاكهة') ||
        meal.contains('تفاح') ||
        meal.contains('ثمرة فاكهة') ||
        meal.contains('موز') ||
        meal.contains('مشمش') ||
        meal.contains('برتقالة') ||
        meal.contains('تفاحة') ||
        meal.contains('عنب') ||
        meal.contains('برتقال') ||
        meal.contains('شريحة بطيخ') ||
        meal.contains('فراولة') ||
        meal.contains('موزة')) {
      return Assets.imagesMealsFruits;
    }
    if (meal.contains('الفشار') || meal.contains('فشار')) {
      return Assets.imagesMealsPopcorn;
    }
    if (meal.contains('بيضة') || meal.contains('بيضه')) {
      return Assets.imagesMealsSingleEgg;
    }
    if (meal.contains('سلطة') ||
        meal.contains('سلطه') ||
        meal.contains('السلطة')) {
      return Assets.imagesMealsSalad;
    }
    if (meal.contains('أرز')) {
      return Assets.imagesMealsRice;
    }
    if (meal == 'بيضة اومليت' ||
        meal == 'بيضه اومليت' ||
        meal.contains('عيون') ||
        meal.contains('بيضة مقلية') ||
        meal.contains('بيضه مقليه')) {
      return Assets.imagesMealsOmleteEyes;
    }
    if (meal == 'معلقه صغيره زيت') {
      return Assets.imagesMealsOliveOil;
    }
    if (meal.contains('زبدة فول سوداني') ||
        meal.contains('زبدة الفول السوداني')) {
      return Assets.imagesMealsPeanutButter;
    }

    if (meal.contains('بازلاء')) {
      return Assets.imagesMealsPea;
    }
    if (meal.contains('شرائح خيار و طماطم')) {
      return Assets.imagesMealsCucumberTomato;
    }
    if (meal.contains('كوب عصير') ||
        meal.contains('عصير') ||
        meal.contains('كوب اناناس') ||
        meal.contains('كوب بطيخ')) {
      return Assets.imagesMealsJuice;
    }
    if (meal.contains('باذنجان')) {
      return Assets.imagesMealsEggplant;
    }
    if (meal.contains('بذور شيا') || meal.contains('بذور الشيا')) {
      return Assets.imagesMealsChiaSeeds;
    }
    if (meal.contains('دجاجة') ||
        meal.contains('دجاجه') ||
        meal.contains('قطعة دجاج')) {
      return Assets.imagesMealsChicken;
    }
    if (meal.contains('معكرونة') || meal.contains('معكرونه')) {
      return Assets.imagesMealsSpaghetti;
    }
    if (meal.contains('جبنة بالطماطم') ||
        meal.contains('جبنه بالطماطم') ||
        meal.contains('قطعه جبن متوسطه الحجم مع الطماطم') ||
        meal.contains('جبن ابيض منزوع الدسم') ||
        meal.contains('جبنة قليلة الدسم') ||
        meal.contains('جبنه قليلة الدسم')) {
      return Assets.imagesMealsLowFatCheese;
    }
    if (meal.contains('سمكة') || meal.contains('سمكه')) {
      return Assets.imagesMealsFish;
    }
    if (meal.contains('جبن مع الخضراوات')) {
      return Assets.imagesMealsVegetableCheese;
    }
    if (meal.contains('خضار مطهي')) {
      return Assets.imagesMealsCookedVege;
    }
    if (meal.contains('دجاج فيليه') ||
        meal.contains('دجاج مخلية') ||
        meal.contains('فاهيتا دجاج')) {
      return Assets.imagesMealsChickenBreast;
    }
    if (meal.contains('فول')) {
      return Assets.imagesMealsBeans;
    }
    if (meal.contains('خضار متقطع') ||
        meal.contains('خضار مقطع') ||
        meal.contains('شرائح طماطم وخضار') ||
        meal == 'خضار') {
      return Assets.imagesMealsVegetable;
    }
    if (meal.contains('جمبري')) {
      return Assets.imagesMealsShrimp;
    }
    if (meal.contains('قهوة') || meal.contains('قهوه')) {
      return Assets.imagesMealsCoffee;
    }
    if (meal.contains('فاصولياء')) {
      return Assets.imagesMealsFasolia;
    }
    if (meal.contains('شوربة') || meal.contains('شوربه')) {
      return Assets.imagesMealsSoup;
    }
    if (meal.contains('شرائح فلفل وطماطم')) {
      return Assets.imagesMealsPepperTomato;
    }
    if (meal.contains('لوز')) {
      return Assets.imagesMealsAlmonds;
    }

    if (meal.contains('كيك بجوز الهند')) {
      return Assets.imagesMealsCoconutCake;
    }
    {
      if (meal.contains('كوب حليب') && meal.contains('شوفان')) {
        return Assets.imagesMealsOatMilk;
      } else if (meal.contains('كوب حليب')) {
        return Assets.imagesMealsMilk;
      }
    }
    if (meal.contains('شوفان') || meal.contains('الشوفان')) {
      return Assets.imagesMealsOat;
    }
    if (meal.contains('بطاطا')) {
      return Assets.imagesMealsSweetPotato;
    }
    if (meal.contains('لوبيا')) {
      return Assets.imagesMealsLubia;
    }
    if (meal.contains('بروكلي')) {
      return Assets.imagesMealsBroccoli;
    }
    if (meal.contains('جزرة')) {
      return Assets.imagesMealsSingleCarrot;
    }
    if (meal.contains('طحينة') || meal.contains('طحينه')) {
      return Assets.imagesMealsTahina;
    }
    if (meal.contains('زيتون')) {
      return Assets.imagesMealsOlive;
    }
    if (meal.contains('خيار وخس')) {
      return Assets.imagesMealsCucumberLettuce;
    }
    if (meal.contains('جرجير')) {
      return Assets.imagesMealsArgula;
    }
    if (meal.contains('بطاطس مكعبات')) {
      return Assets.imagesMealsPotato;
    }
    if (meal.contains('بليلة') || meal.contains('بليله')) {
      return Assets.imagesMealsBlila;
    }
    if (meal.contains('بسكوت') || meal.contains('بسكويت')) {
      return Assets.imagesMealsBiscuit;
    }
    if (meal.contains('كبدة') || meal.contains('كبده')) {
      return Assets.imagesMealsLiver;
    }
    if (meal.contains('شيكولاتة') ||
        meal.contains('داكنة') ||
        meal.contains('شيكولاته')) {
      return Assets.imagesMealsChocolateBar;
    }
    if (meal.contains('بطاطس بيوريه')) {
      return Assets.imagesMealsMashedPotatoes;
    }
    if (meal.contains('خيار وجزر')) {
      return Assets.imagesMealsCarrotCucmber;
    }
    if (meal.contains('الجبن') || meal.contains('جبن')) {
      return Assets.imagesMealsSingleCheese;
    }

    if (meal.contains('جبن قريش بالبقدونس')) {
      return Assets.imagesMealsCottageCheese;
    }
    if (meal.contains('حبة فلفل')) {
      return Assets.imagesMealsSinglePepper;
    }
    if (meal.contains('ثمرة طماطم') || meal.contains('حبة طماطم')) {
      return Assets.imagesMealsSingleTomato;
    }
    if (meal.contains('حمص')) {
      return Assets.imagesMealsHummus;
    }
    if (meal.contains('شرائح خيار وفلفل رومي')) {
      return Assets.imagesMealsPepperCucumber;
    }
    if (meal.contains('شاي اخضر') || meal.contains('نعناع')) {
      return Assets.imagesMealsGreenTea;
    }
    if (meal.contains('زبادي') || meal.contains('الزبادي')) {
      return Assets.imagesMealsYogurt;
    }
    if (meal.contains('ستيك') || meal.contains('لحم')) {
      return Assets.imagesMealsMeat;
    }
    if (meal.contains('التونا') ||
        meal.contains('تونا') ||
        meal.contains('تونة') ||
        meal.contains('التونة')) {
      return Assets.imagesMealsTuna;
    } else {
      return Assets.iconsAppIcon;
    }
  }
}
