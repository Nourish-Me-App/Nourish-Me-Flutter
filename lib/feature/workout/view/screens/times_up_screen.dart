import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/feature/workout/data/item_model.dart';
import 'package:nourish_me/feature/workout/view/screens/details_screen.dart';

class TimesUpScreen extends StatefulWidget {
  const TimesUpScreen({
    super.key, required this.currentIndex, required this.item,
  });
    final int currentIndex;
  final List<ItemModel> item;

  @override
  State<TimesUpScreen> createState() => _TimesUpScreenState();
}

class _TimesUpScreenState extends State<TimesUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/Group 428.png'),
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
            Text(
              'سيبدأ التمرين التالي في غضون لحظات قليلة',
              style: AppTextStyles.cairo18BoldBlack.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 28.h,
            ),
            CircularCountDownTimer(
              width: 100.w,
              height: 100.h,
              duration: 10,
              fillColor: AppColors.mainColor,
              ringColor: AppColors.skipButtonColor,
              autoStart: true,
              controller: CountDownController(),
              isReverse: false,
              onComplete: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        currentIndex: widget.currentIndex + 1,
                        item: item,
                      ),
                    ),
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
