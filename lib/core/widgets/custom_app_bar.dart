import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../feature/home/logic/bot_nav_bar/bot_nav_bar_cubit.dart';
import '../helpers/app_images.dart';
import '../helpers/cache_helper.dart';
import '../theme/app_colors.dart';
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
        child: BlocBuilder<BotNavBarCubit, BotNavBarState>(
          builder: (context, state) {
            return AppBar(
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
                  ? CacheHelper().getData(key: 'image') != null
                      ? CircleAvatar(
                          backgroundColor: AppColors.dietContainerColor,
                          backgroundImage: NetworkImage(
                            CacheHelper().getData(key: 'image'),
                          ),
                        )
                      : SvgPicture.asset(Assets.svgsAppbarlogo)
                  : null,
              actions: title.contains('نظام')
                  ? [
                      CacheHelper().getData(key: 'image') != null
                          ? CircleAvatar(
                              radius: 40.r,
                              backgroundColor: AppColors.dietContainerColor,
                              backgroundImage: NetworkImage(
                                CacheHelper().getData(key: 'image'),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: SvgPicture.asset(
                                Assets.svgsAppbarlogo,
                                height: 70.h,
                              ),
                            ),
                    ]
                  : null,
              centerTitle: true,
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      !title.contains('نظام') ? kToolbarHeight + 8.h : kToolbarHeight + 70.h);
}
