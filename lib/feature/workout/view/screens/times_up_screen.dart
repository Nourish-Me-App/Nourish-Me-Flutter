import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/routing/routes.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';
import 'package:nourish_me/feature/workout/view/screens/details_screen.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TimesUpScreen extends StatefulWidget {
  const TimesUpScreen({
    super.key,
    required this.currentIndex,
    required this.item,
    required this.rest,
  });
  final int currentIndex;
  final List<Exercises> item;
  final int rest;

  @override
  State<TimesUpScreen> createState() => _TimesUpScreenState();
}

class _TimesUpScreenState extends State<TimesUpScreen> {
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesTimeOver),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'عمل رائع ',
              style: AppTextStyles.cairo18BoldBlack.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                'استرح الان وسيبدء التمرين التالي في غضون بضع ثواني ',
                textAlign: TextAlign.center,
                style: AppTextStyles.cairo18BoldBlack.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 28.h,
            ),
            CircularCountDownTimer(
                width: 75.w,
                height: 75.h,
                duration: widget.rest,
                fillColor: AppColors.mainColor,
                ringColor: AppColors.skipButtonColor,
                autoStart: true,
                controller: _controller,
                isReverse: true,
                textStyle: AppTextStyles.cairo18BoldBlack.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(
              height: 32.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextButton.icon(
                    onPressed: () {
                      if (widget.currentIndex < widget.item.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              currentIndex: widget.currentIndex + 1,
                              item: widget.item,
                              length: widget.item.length,
                            ),
                          ),
                        );
                      } else {
                        // Navigate to home page
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.bottomNavBar,
                          (route) => false,
                        );
                      }
                    },
                    icon: Image.asset(Assets.imagesArrowNext),
                    label: Text(
                      'تخطي',
                      style: AppTextStyles.cairo16Boldskip,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
