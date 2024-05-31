import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class MyAppBarWorkOut extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  const MyAppBarWorkOut({
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
          leading: !title.contains('تمرين')
              ? SvgPicture.asset(Assets.svgsAppbarlogo)
              : null,
          actions: title.contains('تمرين')
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
      !title.contains('تمرين') ? kToolbarHeight + 8.h : kToolbarHeight + 70.h);
}
