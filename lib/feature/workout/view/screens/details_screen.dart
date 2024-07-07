import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_text_styles.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key,
      required this.currentIndex,
      required this.item,
      required this.length});
  final int currentIndex;
  final List<Exercises> item;
  final int length;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;

  void _startCountdown(String reps) {
    final seconds = int.tryParse(reps.replaceAll(RegExp(r'\D'), ''));
    if (seconds != null && seconds > 15) {
      setState(() {
        _remainingSeconds = seconds;
      });

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          setState(() {
            _remainingSeconds--;
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text('${widget.currentIndex + 1}/${widget.item.length}',
                style: AppTextStyles.cairo16Boldskip
                    .copyWith(color: AppColors.mainColor, fontSize: 16.sp)),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _buildContent(
          widget.currentIndex,
          widget.item[widget.currentIndex],
          widget.length,
        ),
      ),
    );
  }

  Widget _buildContent(int index, Exercises item, int length) {
    bool hasSets = item.sets != null;
    bool hasReps = item.repeats != null;
    bool hasRepsWord = hasReps && item.repeats!.toLowerCase().contains('reps');

    String setsDisplay = '';
    String repsDisplay = '';

    // Determine how to display sets and reps based on conditions
    if (!hasSets && !hasReps) {
      // If neither sets nor reps are present
      setsDisplay = '';
      repsDisplay = '';
    } else if (!hasSets && hasReps) {
      // If sets are absent but reps are present
      setsDisplay = '';
      repsDisplay = item.repeats!;
    } else if (hasSets && !hasReps) {
      // If sets are present but reps are absent
      setsDisplay = item.sets!;
      repsDisplay = 'reps';
    } else {
      // If both sets and reps are present
      setsDisplay = item.sets!;
      repsDisplay = item.repeats!;
    }

    // Add the word "sets" if it's not present in setsDisplay
    if (hasSets && !setsDisplay.toLowerCase().contains('set')) {
      setsDisplay = '${item.sets} sets';
    }

    return Center(
      key: ValueKey<int>(index),
      child: Column(
        children: [
          SizedBox(height: 130.h),
          SizedBox(
              width: 378.w,
              height: 200.h,
              child: CachedNetworkImage(imageUrl: item.image!)),
          SizedBox(height: 26.h),
          Text(
            item.name!,
            style: AppTextStyles.cairo18BoldBlack
                .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 26.h),
          if (setsDisplay.isNotEmpty && repsDisplay.isNotEmpty)
            Text(
              "$setsDisplay - $repsDisplay",
              style: AppTextStyles.cairo18BoldBlack,
            ),
          if (setsDisplay.isNotEmpty && repsDisplay.isEmpty)
            Text(
              setsDisplay,
              style: AppTextStyles.cairo18BoldBlack,
            ),
          if (setsDisplay.isEmpty && repsDisplay.isNotEmpty)
            Text(
              repsDisplay,
              style: AppTextStyles.cairo18BoldBlack,
            ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  if (index < widget.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            DetailsScreen(
                          currentIndex: index + 1,
                          item: widget.item,
                          length: widget.length,
                        ),
                        transitionDuration: const Duration(seconds: 1),
                      ),
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.bottomNavBar,
                        ModalRoute.withName(Routes.bottomNavBar));
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: WidgetStateProperty.all(0),
                ),
                child: Text(
                  'انهاء',
                  style: AppTextStyles.cairosemibold14white,
                ),
              ),
            ),
          ),
          SizedBox(height: 140.h),
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
                              length: widget.length,
                            ),
                            transitionDuration: const Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Transform.flip(
                        filterQuality: FilterQuality.high,
                        flipX: true,
                        child: Image.asset(Assets.imagesArrowNext),
                      ),
                      label: Text(
                        'السابق',
                        style: AppTextStyles.cairo16Boldskip,
                      ),
                    ),
                  ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    onPressed: () {
                      if (index < widget.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                DetailsScreen(
                              currentIndex: index + 1,
                              item: widget.item,
                              length: widget.length,
                            ),
                            transitionDuration: const Duration(seconds: 1),
                          ),
                        );
                      } else {
                        HelperMethods.showCustomSnackBarSuccess(
                            context, 'تم الانتهاء من تمرين اليوم');
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
