import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/helpers/app_images.dart';

import '../widgets/setting_header.dart';
import '../widgets/settings_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 64.h),
          child: Column(
            children: [
              const SettingHeader(),
              SizedBox(height: 48.h),
              SettingsContainer(
                icon: Assets.svgsSettingsEmailChange,
                title: 'تغيير البريد الالكتروني',
                showBackIcon: true,
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              SettingsContainer(
                icon: Assets.svgsSettingsPassChange,
                title: 'تغيير كلمة المرور',
                showBackIcon: true,
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              SettingsContainer(
                icon: Assets.svgsSettingsRate,
                title: 'تقييم التطبيق',
                showBackIcon: false,
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              SettingsContainer(
                icon: Assets.svgsSettingsLogout,
                title: 'تسجيل الخروج',
                showBackIcon: false,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      content: SizedBox(
                        height: 166.h,
                        width: 325.w,
                        child: const Column(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
