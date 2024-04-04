import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class SocialIntegration extends StatelessWidget {
  final Function() integrateWithFacebook;
  final Function() integrateWithGoogle;
  const SocialIntegration({
    super.key,
    required this.integrateWithFacebook,
    required this.integrateWithGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                'أو من خلال',
                style: AppTextStyles.cairo12SemiBoldBlack,
              ),
            ),
            const Expanded(
              child: Divider(
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlatformCard(
                integrateWith: integrateWithFacebook,
                platformIcon: Assets.iconsFacbookFilledBlue,
              ),
              SizedBox(width: 32.w),
              PlatformCard(
                integrateWith: integrateWithGoogle,
                platformIcon: Assets.iconsGoogle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlatformCard extends StatelessWidget {
  const PlatformCard({
    super.key,
    required this.integrateWith,
    required this.platformIcon,
  });

  final Function() integrateWith;
  final String platformIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: integrateWith,
      child: SizedBox(
        height: 60.h,
        width: 60.h,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          color: AppColors.tFFEmptyColor,
          child: Center(
            child: SvgPicture.asset(
              width: 30.w,
              height: 30.h,
              platformIcon,
            ),
          ),
        ),
      ),
    );
  }
}
