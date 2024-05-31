import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import '../../../../core/imports/app_routes_imports.dart';
import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/item_model.dart';
import 'details_screen.dart';

class TimesUpScreen extends StatefulWidget {
  const TimesUpScreen({
    super.key,
    required this.currentIndex,
    required this.item,
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
              duration: 10,
              fillColor: AppColors.mainColor,
              ringColor: AppColors.skipButtonColor,
              autoStart: true,
              controller: CountDownController(),
              isReverse: false,
              textStyle: AppTextStyles.cairo18BoldBlack.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              onComplete: () {
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
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNav(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
