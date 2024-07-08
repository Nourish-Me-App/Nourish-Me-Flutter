import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../main.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController firstFadeAnimationController,
      secondFadeAnimationController;

  late Animation<double> firstFadeAnimation;
  late Animation<Offset> secondFadeAnimation;
  late CacheHelper cacheHelper;
  bool isShowWelcomeText = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    myFirstFadeAnimation();
    mySecondFadeAnimation();
    cacheHelper = CacheHelper();
    timer = Timer(const Duration(milliseconds: 4000), () {
      if (showOnBoarding == null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.onBoarding,
          (route) => false,
        );
      } else {
        if (cacheHelper.getData(key: AppConstants.rememberMeToken) == null &&
            cacheHelper.getData(key: 'googleRememberMe') == null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signUpScreen,
            (route) => false,
          );
        } else {
          if (cacheHelper.getData(key: AppConstants.rememberMeToken) != null) {
            if (cacheHelper.getData(
                    key: AppConstants.isFirstQuestionsComplete) ==
                'no') {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.questions,
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.bottomNavBar,
                (route) => false,
              );
            }
          }
          if (cacheHelper.getData(key: 'googleRememberMe') != null) {
            if (cacheHelper.getData(key: 'isDataSaved') == "no") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.continueRegisterScreen,
                arguments: 'googleLogin',
                (route) => false,
              );
            } else {
              if (cacheHelper.getData(key: 'isFirstQuestionsCompleteGoogle') ==
                  'no') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.questions,
                  arguments: 'googleLogin',
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.bottomNavBar,
                  (route) => false,
                );
              }
            }
          }
        }
      }
    });
  }

  void myFirstFadeAnimation() {
    firstFadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
    firstFadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(
      CurvedAnimation(
          parent: firstFadeAnimationController, curve: Curves.easeInQuad),
    );
  }

  void mySecondFadeAnimation() {
    secondFadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();
    secondFadeAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.5),
    ).animate(
      CurvedAnimation(
          parent: secondFadeAnimationController, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    firstFadeAnimationController.dispose();
    secondFadeAnimationController.dispose();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 210.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: firstFadeAnimation,
                child: SlideTransition(
                  position: secondFadeAnimation,
                  child: Image.asset(
                    Assets.imagesSplashSplashLogoTitle,
                  ),
                ),
              ),
              FadeTransition(
                opacity: firstFadeAnimation,
                child: Image.asset(
                  Assets.imagesSplashSplashLogoBody,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
