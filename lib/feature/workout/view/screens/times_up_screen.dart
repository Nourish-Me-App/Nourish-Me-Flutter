import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/helper_methods.dart';
import 'package:nourish_me/core/routing/routes.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';
import 'package:nourish_me/feature/workout/view/screens/details_screen.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class TimesUpScreen extends StatefulWidget {
  const TimesUpScreen({
    super.key,
    required this.currentIndex,
    required this.item,
    required this.rest,
    required this.betweenSets,
    required this.currentSet,
    required this.remainingSeconds,
  });

  final int currentIndex;
  final List<Exercises> item;
  final int rest;
  final bool betweenSets;
  final int currentSet;
  final int remainingSeconds;

  @override
  State<TimesUpScreen> createState() => _TimesUpScreenState();
}

class _TimesUpScreenState extends State<TimesUpScreen> {
  final CountDownController _controller = CountDownController();

  void _navigateToNextScreen() {
    if (!mounted) return;

    if (widget.betweenSets) {
      // Navigate to the next set
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            currentIndex: widget.currentIndex,
            item: widget.item,
            length: widget.item.length,
            currentSet: widget.currentSet,
            remainingSeconds: int.parse(widget
                .item[widget.currentIndex].repeats!
                .replaceAll(RegExp(r'\D'), '')),
          ),
        ),
      );
    } else {
      // Navigate to the next workout or completion message
      if (widget.currentIndex < widget.item.length - 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              currentIndex: widget.currentIndex + 1,
              item: widget.item,
              length: widget.item.length,
              currentSet: 1,
              remainingSeconds: int.parse(widget
                  .item[widget.currentIndex + 1].repeats!
                  .replaceAll(RegExp(r'\D'), '')),
            ),
          ),
        );
      } else {
        // If it's the last workout, show completion message and navigate to results
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        HelperMethods.showCustomSnackBarSuccess(
            context, 'تم الانتهاء من تمارين اليوم ');
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.bottomNavBar,
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastWorkout = widget.currentIndex == widget.item.length - 1;
    return Scaffold(
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
                isLastWorkout
                    ? 'تم الانتهاء من تمارين اليوم '
                    : widget.betweenSets
                        ? 'استرح الان وستبدء المجموعه التالية خلال ثواني'
                        : 'استرح الان وسيبدء التمرين التالي في غضون بضع ثواني ',
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
            if (!isLastWorkout)
              CircularCountDownTimer(
                width: 75.w,
                height: 75.h,
                duration: widget.rest < 30 ? 30 : widget.rest,
                fillColor: AppColors.mainColor,
                ringColor: AppColors.skipButtonColor,
                autoStart: true,
                controller: _controller,
                isReverse: true,
                textStyle: AppTextStyles.cairo18BoldBlack.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                onComplete: _navigateToNextScreen,
              ),
            SizedBox(
              height: 32.h,
            ),
            if (isLastWorkout)
              CustomButton(
                  width: 200.w,
                  buttonText: 'العوده الي النتائج',
                  buttonAction: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.bottomNavBar,
                      (Route<dynamic> route) => false,
                    );
                  },
                  buttonStyle: AppTextStyles.cairo18BoldBlack.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
