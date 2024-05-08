import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class MyTabBar extends StatefulWidget implements PreferredSizeWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyTabBarState extends State<MyTabBar> {
  int currentIndex = 0;
  List<String> days = [
    'السبت',
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة'
  ];
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      padding: EdgeInsets.only(right: 24.w, left: 12.w),
      labelPadding: const EdgeInsets.all(4),
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      isScrollable: true,
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      tabs: List.generate(
        7,
        (index) => Tab(
          child: Container(
            height: 32.h,
            width: 87.w,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.mainColor
                  : AppColors.counterColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                days[index],
                style: currentIndex == index
                    ? AppTextStyles.cairo16SemiBoldBlack
                        .copyWith(color: Colors.white)
                    : AppTextStyles.cairo16SemiBoldBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
