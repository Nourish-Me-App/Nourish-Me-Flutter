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
          height: 80.h,
          width: 52.w,
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
                  radius: 30.r,
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 52.h,
                  left: 26.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.mainColor,
                    radius: 13.r,
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
