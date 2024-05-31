import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/item_model.dart';
import 'times_up_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key, required this.currentIndex, required this.item});
  final int currentIndex;
  final List<ItemModel> item;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  static const int countdownDuration = 5;
  int remainingTime = countdownDuration;
  Timer? _timer;
  bool isRunning = false;
  bool isPaused = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _timer?.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TimesUpScreen(
                        currentIndex: widget.currentIndex,
                        item: widget.item,
                      )));
        }
      });
    });
  }

  void _onButtonPressed() {
    if (!isRunning) {
      _startTimer();
      setState(() {
        isRunning = true;
        isPaused = false;
      });
    } else if (isRunning && !isPaused) {
      _timer?.cancel();
      setState(() {
        isPaused = true;
      });
    } else if (isPaused) {
      _startTimer();
      setState(() {
        isPaused = false;
      });
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text('${widget.currentIndex + 1}/8'),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _buildContent(widget.currentIndex),
      ),
    );
  }

  Widget _buildContent(int index) {
    final item = widget.item[index];
    return Center(
      key: ValueKey<int>(index),
      child: Column(
        children: [
          Image.asset(
            item.image!,
            height: 265.h,
          ),
          SizedBox(
            height: 26.h,
          ),
          Text(
            item.name!,
            style: AppTextStyles.cairo18BoldBlack
                .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 26.h,
          ),
          Text(
            _formatTime(remainingTime),
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 120.h),
            child: SizedBox(
              width: double.infinity,
              height: 32.h,
              child: ElevatedButton(
                onPressed: _onButtonPressed,
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.mainColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  elevation: WidgetStateProperty.all(0),
                ),
                child: Text(
                    isRunning ? (isPaused ? 'استمرار' : 'توقف') : 'أبدا',
                    style: AppTextStyles.cairosemibold16white),
              ),
            ),
          ),
          SizedBox(
            height: 140.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (index > 0)
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                DetailsScreen(
                              currentIndex: index - 1,
                              item: widget.item,
                            ),
                            transitionDuration: const Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Image.asset(Assets.imagesArrowNext),
                      label: Text(
                        'السابق',
                        style: AppTextStyles.cairo16Boldskip,
                      ),
                    ),
                  ),
                if (index > 0)
                  const VerticalDivider(
                    color: Colors.red,
                    thickness: 5,
                  ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextButton.icon(
                    onPressed: () {
                      if (index < widget.item.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                DetailsScreen(
                              currentIndex: index + 1,
                              item: widget.item,
                            ),
                            transitionDuration: const Duration(seconds: 1),
                          ),
                        );
                      } else {
                        HelperMethods.showCustomSnackBarSuccess(
                            context, 'تم الانتهاء من التمرين');
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
          )
        ],
      ),
    );
  }
}
