import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/app_images.dart';
import '../theme/app_text_styles.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  const MyAppBar({
    super.key,
    required this.title,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: AppBar(
          bottom: bottom,
          leadingWidth: !title.contains('نظام') ? 80.w : null,
          title: Text(
            title,
            style: AppTextStyles.cairo12ExtraBoldTFFContentColor.copyWith(
              fontSize: 17.sp,
              color: Colors.black,
            ),
          ),
          leading: !title.contains('نظام')
              ? SvgPicture.asset(Assets.svgsAppbarlogo)
              : null,
          actions: title.contains('نظام')
              ? [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: SvgPicture.asset(
                      Assets.svgsAppbarlogo,
                      height: 70.h,
                    ),
                  ),
                ]
              : null,
          centerTitle: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      !title.contains('نظام') ? kToolbarHeight + 8.h : kToolbarHeight + 70.h);
}
