import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/helper_methods.dart';
import 'package:nourish_me/core/routing/routes.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'times_up_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key,
      required this.currentIndex,
      required this.item,
      required this.length,
      this.currentSet = 1,
      this.remainingSeconds});

  final int currentIndex;
  final List<Exercises> item;
  final int length;
  final int currentSet;
  final int? remainingSeconds;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isPaused = true;
  bool _isCountdownActive = false;
  int _currentSet = 1;

  @override
  void initState() {
    super.initState();
    String repsDisplay = widget.item[widget.currentIndex].repeats ?? '0 sec';
    _remainingSeconds =
        int.tryParse(repsDisplay.replaceAll(RegExp(r'\D'), '')) ?? 0;
    _currentSet = widget.currentSet;
    if (_remainingSeconds > 0) {
      _startCountdown(_remainingSeconds.toString());
    }
  }

  void _startCountdown(String reps, {bool fromPlayButton = false}) {
    if (fromPlayButton) {
      final seconds = int.tryParse(reps.replaceAll(RegExp(r'\D'), ''));
      if (seconds != null && reps.toLowerCase().contains('sec')) {
        if (mounted) {
          setState(() {
            _remainingSeconds = seconds;
            _isPaused = false;
            _isCountdownActive = true; // Activate countdown
          });
        }
      }
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0 && !_isPaused) {
        if (mounted) {
          setState(() {
            _remainingSeconds--;
          });
        }
      } else {
        timer.cancel();
        if (_remainingSeconds == 0) {
          _handleSetCompletion();
        }
      }
    });
  }

  void _handleSetCompletion() {
    if (_currentSet < int.parse(widget.item[widget.currentIndex].sets ?? '1')) {
      if (mounted) {
        setState(() {
          _currentSet++;
        });
      }
      _navigateToTimesUpScreen(betweenSets: true);
    } else {
      _navigateToTimesUpScreen(betweenSets: false);
    }
  }

  void _stopCountdown() {
    if (mounted) {
      setState(() {
        _timer?.cancel();
        String repsDisplay =
            widget.item[widget.currentIndex].repeats ?? '0 sec';
        _remainingSeconds =
            int.tryParse(repsDisplay.replaceAll(RegExp(r'\D'), '')) ?? 0;
        _isPaused = true;
        _isCountdownActive = false; // Deactivate countdown
      });
    }
  }

  _navigateToTimesUpScreen({required bool betweenSets}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TimesUpScreen(
          currentIndex: widget.currentIndex,
          item: widget.item,
          rest: int.parse(widget.item[widget.currentIndex].rest ?? '60'),
          betweenSets: betweenSets,
          currentSet: _currentSet,
          remainingSeconds: _remainingSeconds,
        ),
      ),
    ).then((_) {
      if (!mounted) return;

      if (betweenSets) {
        setState(() {
          _remainingSeconds = int.parse(widget
              .item[widget.currentIndex].repeats!
              .replaceAll(RegExp(r'\D'), ''));
        });
        _startCountdown(widget.item[widget.currentIndex].repeats!);
      } else {
        _moveToNextWorkout();
      }
    });
  }

  void _moveToNextWorkout() {
    if (!mounted) return;

    if (widget.currentIndex < widget.length - 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => DetailsScreen(
            currentIndex: widget.currentIndex + 1,
            item: widget.item,
            length: widget.length,
          ),
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      HelperMethods.showCustomSnackBarSuccess(
          context, 'تم الانتهاء من تمارين اليوم');
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.bottomNavBar,
        ModalRoute.withName(Routes.bottomNavBar),
      );
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
                    .copyWith(color: AppColors.mainColor, fontSize: 14.sp)),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
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

    String setsDisplay = '';
    String repsDisplay = '';

    if (!hasSets && !hasReps) {
      setsDisplay = '';
      repsDisplay = '';
    } else if (!hasSets && hasReps) {
      setsDisplay = '';
      repsDisplay = item.repeats!;
    } else if (hasSets && !hasReps) {
      setsDisplay = item.sets!;
      repsDisplay = 'reps';
    } else {
      setsDisplay = item.sets!;
      repsDisplay = item.repeats!;
    }

    if (hasSets && !setsDisplay.toLowerCase().contains('set')) {
      setsDisplay = '${item.sets} sets';
    }

    if (hasReps && !repsDisplay.toLowerCase().contains('rep')) {
      repsDisplay.toLowerCase().contains('sec') ||
              repsDisplay.toLowerCase().contains('min')
          ? repsDisplay = '${item.repeats}'
          : repsDisplay = '${item.repeats} reps';
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Center(
        key: ValueKey<int>(index),
        child: Column(
          children: [
            Text(
              item.name!,
              style: AppTextStyles.cairo18BoldBlack
                  .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            repsDisplay.toLowerCase().contains('sec')
                ? SizedBox(height: 76.h)
                : SizedBox(height: 96.h),
            SizedBox(
                width: 378.w,
                height: 200.h,
                child: CachedNetworkImage(imageUrl: item.image!)),
            repsDisplay.toLowerCase().contains('sec')
                ? SizedBox(height: 52.h)
                : SizedBox(height: 64.h),
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
            SizedBox(height: 32.h),
            if (repsDisplay.toLowerCase().contains('sec'))
              Column(
                children: [
                  Text(
                    '00:$_remainingSeconds',
                    style: AppTextStyles.cairo25BoldBlack,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          size: 36.r,
                        ),
                        onPressed: _isCountdownActive
                            ? null
                            : () {
                                _startCountdown(repsDisplay,
                                    fromPlayButton: true);
                              },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.stop,
                          size: 36.r,
                        ),
                        onPressed: _stopCountdown,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 120.w),
              child: SizedBox(
                width: double.infinity,
                height: 32.h,
                child: ElevatedButton(
                  onPressed: () => _navigateToTimesUpScreen(betweenSets: false),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.mainColor),
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
            const Spacer(),
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
                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        DetailsScreen(
                                  currentIndex: index - 1,
                                  item: widget.item,
                                  length: widget.length,
                                  currentSet: _currentSet,
                                  remainingSeconds: _remainingSeconds,
                                ),
                                transitionDuration: const Duration(seconds: 0),
                              ),
                            );
                          }
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
                                currentSet: _currentSet,
                                remainingSeconds: _remainingSeconds,
                              ),
                              transitionDuration: const Duration(seconds: 1),
                            ),
                          );
                        } else {
                          // Navigate to home page when finished
                          if (mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.bottomNavBar,
                                ModalRoute.withName(Routes.bottomNavBar));
                          }
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
      ),
    );
  }
}
