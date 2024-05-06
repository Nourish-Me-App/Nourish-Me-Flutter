import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingsContainer extends StatelessWidget {
  final void Function()? onTap;
  final String title, icon;
  final bool showBackIcon;
  const SettingsContainer({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    required this.showBackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.dietContainerColor,
      ),
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Row(
          children: [
            showBackIcon
                ? Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.settingsContainerIconColor,
                    size: 18.r,
                  )
                : Container(),
            const Spacer(),
            Text(
              title,
              style: AppTextStyles.cairo16SemiBoldBlack
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 16.w),
            SvgPicture.asset(icon),
          ],
        ),
      ),
    );
  }
}
