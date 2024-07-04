import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_border_button.dart';
import '../widgets/custom_button.dart';
import 'app_images.dart';

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

  static Future<Widget?> showLoadingAlertDialog(context) {
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

  static void svgPrecacheImage() {
    const cacheSvgImages = [
      Assets.svgsResultsNoConnection,
      Assets.svgsAuthQuestion,
      Assets.svgsAppLogo,
      Assets.svgsAuthCongratulation,
      Assets.svgsAuthForgotpasswoedscreen,
      Assets.svgsAuthVerify,
      Assets.svgsAuthFemale,
      Assets.svgsAuthMale,
      Assets.svgsResultsBreak,
      Assets.imagesTimeOver,
      Assets.iconsFacbookFilledBlue,
      Assets.iconsGoogle,
      Assets.svgsAppbarlogo,
      Assets.svgsResultsAge,
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
      Assets.svgsResultsVector,
      Assets.svgsResultsWaterdrop,
      Assets.svgsResultsWeightSelected,
      Assets.svgsResultsWeightlift,
      Assets.svgsSettingsLogout,
      Assets.svgsSettingsEmailChange,
      Assets.svgsSettingsPassChange,
      Assets.svgsSettingsRate,
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
          meal.contains('خبز') ||
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
        meal.contains('فواكه') ||
        meal.contains('تفاح') ||
        meal.contains('ثمرة فاكهة') ||
        meal.contains('موز') ||
        meal.contains('مشمش') ||
        meal.contains('كيوي') ||
        meal.contains('برتقالة') ||
        meal.contains('تفاحة') ||
        meal.contains('جواف') ||
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
    if (meal.contains('بيضة') ||
        meal.contains('بيضه') ||
        meal.contains('بيضات') ||
        meal.contains('بيضتين') ||
        meal.contains('بيض')) {
      return Assets.imagesMealsSingleEgg;
    }
    if (meal.contains('سلطة') ||
        meal.contains('سلطه') ||
        meal.contains('السلطة')) {
      return Assets.imagesMealsSalad;
    }
    if (meal.contains('أرز') || meal.contains('ارز') || meal.contains('رز')) {
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
    if (meal == ' خس' || meal == 'خس ' || meal == 'خس') {
      return Assets.imagesMealsLettuce;
    }
    if (meal.contains('زبدة فول سوداني') ||
        meal.contains('زبدة الفول السوداني')) {
      return Assets.imagesMealsPeanutButter;
    }

    if (meal.contains('بازلاء')) {
      return Assets.imagesMealsPea;
    }
    if (meal.contains('طماطم') && meal.contains('خيار')) {
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
    if (meal.contains('شيا') || meal.contains('الشيا')) {
      return Assets.imagesMealsChiaSeeds;
    }
    if (meal.contains('دجاجة') ||
        meal.contains('دجاجه') ||
        meal.contains('دجاج')) {
      return Assets.imagesMealsChicken;
    }
    if (meal.contains('معكرونة') ||
        meal.contains('معكرونه') ||
        meal.contains('مكرونه') ||
        meal.contains('مكرونة')) {
      return Assets.imagesMealsSpaghetti;
    }
    if (meal.contains('جبنة بالطماطم') ||
        meal.contains('جبنه بالطماطم') ||
        meal.contains('قطعه جبن متوسطه الحجم مع الطماطم') ||
        meal.contains('جبن ابيض منزوع الدسم') ||
        meal.contains('جبن منزوع الدسم') ||
        meal.contains('جبنة قليلة الدسم') ||
        (meal.contains('جبن') && meal.contains('زيت')) ||
        meal.contains('جبنه قليلة الدسم')) {
      return Assets.imagesMealsLowFatCheese;
    }
    if (meal.contains('سمكة') || meal.contains('سمكه')) {
      return Assets.imagesMealsFish;
    }
    if (meal.contains('جبن مع الخضراوات')) {
      return Assets.imagesMealsVegetableCheese;
    }
    if (meal.contains('خضار سوتيه') ||
        meal.contains('خضار مطهي') ||
        meal.contains('الخضار المطهي') ||
        meal.contains('خضراوات مطهي') ||
        meal.contains('خضار مطبوخ')) {
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
        meal.contains('خضار') ||
        meal.contains('خضروات') ||
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

    if (meal.contains('كيك بجوز الهند') || meal.contains('كعك بجوز الهند')) {
      return Assets.imagesMealsCoconutCake;
    }
    {
      if (meal.contains('كوب حليب') && meal.contains('شوفان')) {
        return Assets.imagesMealsOatMilk;
      } else if (meal.contains('كوب حليب')) {
        return Assets.imagesMealsMilk;
      }
      if (meal.contains('بسكويت') ||
          meal.contains('بسكوت') && meal.contains('شوفان')) {
        return Assets.imagesMealsBiscuit;
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
    if (meal.contains('خيار') && meal.contains('خس')) {
      return Assets.imagesMealsCucumberLettuce;
    }
    if (meal.contains('جرجير')) {
      return Assets.imagesMealsArgula;
    }
    if (meal.contains('بطاطس')) {
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
        meal.contains('الشيكولاتة') ||
        meal.contains('الشيكولاته') ||
        meal.contains('شوكولاته') ||
        meal.contains('شوكولاتة') ||
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
    if (meal.contains('ستيك') || meal.contains('لحم') || meal.contains('كفت')) {
      return Assets.imagesMealsMeat;
    }
    if (meal.contains('التونا') ||
        meal.contains('تونا') ||
        meal.contains('تونة') ||
        meal.contains('تونه') ||
        meal.contains('التونه') ||
        meal.contains('التونة')) {
      return Assets.imagesMealsTuna;
    } else {
      return Assets.imagesMealsDefaultFood;
    }
  }

  static Future<Widget?> showLogoutAlertDialog(
      context, Function() buttonAction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 277.h,
          width: 325.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              children: [
                Image.asset(
                  Assets.imagesLogoutWarning,
                  height: 120.h,
                  width: 120.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  'هل تريد تسجيل الخروج من حسابك ؟',
                  textDirection: TextDirection.rtl,
                  style: AppTextStyles.cairo16SemiBoldBlack
                      .copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: 'تسجيل الخروج',
                        buttonAction: buttonAction,
                        height: 35.h,
                        buttonStyle: AppTextStyles.cairo14SemiBoldWhite,
                        borderRadius: 20.r,
                        color: AppColors.tFFErrorColor,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomBorderButton(
                        buttonText: 'إلغاء',
                        buttonAction: () {
                          Navigator.pop(context);
                        },
                        height: 30.h,
                        buttonStyle: AppTextStyles.cairo14SemiBoldWhite
                            .copyWith(color: AppColors.mainColor),
                        borderRadius: 20.r,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String calculateBMI(String? massIndex) {
    double bmi = double.parse(massIndex!);
    // ignore: unused_local_variable
    String bmiCategory;

    switch (bmiCategory = bmi <= 18.5
        ? 'نقص وزن'
        : bmi >= 18.5 && bmi <= 24.9
            ? 'وزن طبيعي'
            : bmi >= 25 && bmi <= 29.9
                ? 'زيادة وزن'
                : bmi >= 30 && bmi <= 34.9
                    ? 'سمنة درجة اولى'
                    : bmi >= 35 && bmi <= 39.9
                        ? 'سمنة درجة ثانية'
                        : bmi >= 40
                            ? 'سمنة مفرطة'
                            : 'غير معروف') {
      case 'نقص وزن':
        return 'نحيف';
      case 'وزن طبيعي':
        return 'وزن طبيعي';
      case 'زيادة وزن':
        return 'سمين';
      case 'سمنة درجة اولى':
        return 'سمنة درجة اولى';
      case 'سمنة درجة ثانية':
        return 'سمنة درجة ثانية';
      case 'سمنة مفرطة':
        return 'سمنة مفرطة';
      default:
        return 'غير معروف';
    }
  }

  static List<Exercises> setDaysExercises(String day, List<Exercises> data) {
    return data.where((element) {
      return element.day == day;
    }).toList();
  }
}
