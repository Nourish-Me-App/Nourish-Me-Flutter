import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DietsSeparator extends StatelessWidget {
  const DietsSeparator({
    super.key,
    required this.whatToEat,
  });

  final String whatToEat;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            whatToEat,
            style: AppTextStyles.cairo18BoldBlack.copyWith(fontSize: 16.sp),
          ),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 5.r,
            backgroundColor: AppColors.mainColor,
          ),
        ],
      ),
    );
  }
}
