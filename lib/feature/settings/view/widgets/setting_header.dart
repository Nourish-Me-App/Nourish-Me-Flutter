import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        CircleAvatar(
          backgroundColor: AppColors.dietContainerColor,
          radius: 24.r,
          child: const Center(
            child: Icon(
              Icons.person,
              color: AppColors.mainColor,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manar Gehad',
              style: AppTextStyles.cairo18BoldBlack,
            ),
            Text(
              'manargehad@gmail.com',
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
