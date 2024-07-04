import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../home/logic/bot_nav_bar/bot_nav_bar_cubit.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/cache_helper.dart';
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
        child: BlocBuilder<BotNavBarCubit, BotNavBarState>(
          builder: (context, state) {
            return AppBar(
              bottom: bottom,
              title: Text(
                title,
                style: AppTextStyles.cairo12ExtraBoldTFFContentColor.copyWith(
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
              actions: [
                CacheHelper().getData(key: 'image') != null
                    ? Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                CacheHelper().getData(key: 'image'),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: SvgPicture.asset(
                          Assets.svgsAppbarlogo,
                          height: 70.h,
                        ),
                      ),
              ],
              centerTitle: true,
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 70.h);
}
