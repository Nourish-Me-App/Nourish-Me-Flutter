import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChooseImageSourceDialog extends StatelessWidget {
  final void Function()? galleryPick;
  final void Function()? cameraPick;
  const ChooseImageSourceDialog({super.key, this.galleryPick, this.cameraPick});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.mainColor,
      content: SizedBox(
        height: 175.h,
        width: 325.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: ListTile(
                  onTap: galleryPick,
                  contentPadding: EdgeInsets.zero,
                  trailing: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  title: Text(
                    'اختر صورة من الاستوديو',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.cairo16BoldWhite,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: ListTile(
                  onTap: cameraPick,
                  contentPadding: EdgeInsets.zero,
                  trailing: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  title: Text(
                    'اختر صورة من الكاميرا',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.cairo16BoldWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
