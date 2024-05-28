import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/helpers/cache_helper.dart';
import 'package:nourish_me/main.dart';

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
  bool isShowWelcomeText = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    myFirstFadeAnimation();
    mySecondFadeAnimation();
    timer = Timer(const Duration(milliseconds: 5000), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        showOnBoarding == null
            ? Routes.onBoarding
            : CacheHelper().getData(key: AppConstants.rememberMeToken) == null
                ? Routes.signUpScreen
                : CacheHelper().getData(
                            key: AppConstants.isFirstQuestionsComplete) ==
                        'no'
                    ? Routes.questions
                    : Routes.bottomNavBar,
        (route) => false,
      );
    });
  }

  void myFirstFadeAnimation() {
    firstFadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
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
      duration: const Duration(milliseconds: 4000),
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