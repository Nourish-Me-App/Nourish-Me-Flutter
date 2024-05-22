import 'dart:async';

import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/imports/questions_screen_imports.dart';
import 'package:nourish_me/feature/workout/data/item_model.dart';
import 'package:nourish_me/feature/workout/view/screens/times_up_screen.dart';

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
          Text('${widget.currentIndex + 1}/8'),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(widget.item[widget.currentIndex].image!),
            SizedBox(
              height: 26.h,
            ),
            Text(
              widget.item[widget.currentIndex].name!,
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
                        MaterialStateProperty.all(AppColors.mainColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
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
                  if (widget.currentIndex > 0)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  currentIndex: widget.currentIndex - 1,
                                  item: widget.item,
                                ),
                              ),
                            );
                          },
                          icon: Image.asset(
                              'assets/images/icon-park-outline_prev.png'),
                          label: Text(
                            'السابق',
                            style: AppTextStyles.cairo16Boldskip,
                          )),
                    ),
                  if (widget.currentIndex > 0)
                    const VerticalDivider(
                      color: Colors.red,
                      thickness: 5,
                    ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                        onPressed: () {
                          if (widget.currentIndex < widget.item.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  currentIndex: widget.currentIndex + 1,
                                  item: widget.item,
                                ),
                              ),
                            );
                          } else {
                            HelperMethods.showCustomSnackBarSuccess(
                                context, 'تم الانتهاء من التمرين');
                          }
                        },
                        icon: Image.asset(
                            'assets/images/icon-park-outline_next.png'),
                        label: Text(
                          'تخطي',
                          style: AppTextStyles.cairo16Boldskip,
                        )),
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
