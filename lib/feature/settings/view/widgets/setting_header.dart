import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 120.h,
          width: 85.w,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: () {},
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.dietContainerColor,
                  radius: 70.r,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: AppColors.mainColor,
                      size: 40.r,
                    ),
                  ),
                ),
                Positioned(
                  top: 80.h,
                  left: 50.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.mainColor,
                    radius: 17.r,
                    child: Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 13.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CacheHelper().getData(key: 'name'),
              style: AppTextStyles.cairo18BoldBlack,
            ),
            Text(
              CacheHelper().getData(key: 'email'),
              style: AppTextStyles.cairo16SemiBoldBlack.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
