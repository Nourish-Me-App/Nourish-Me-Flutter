import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/logic/bot_nav_bar/bot_nav_bar_cubit.dart';
import '../../logic/cubit/settings_cubit.dart';
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
          child: BlocListener<SettingsCubit, SettingsState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                CacheHelper cacheHelper = CacheHelper();
                Navigator.pop(context);
                HelperMethods.showCustomSnackBarSuccess(
                  context,
                  'تم تسجيل الخروج بنجاح',
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginScreen,
                  (route) => false,
                );
                cacheHelper.deleteSecuredData(key: AppConstants.token);
                cacheHelper.removeData(key: AppConstants.rememberMeToken);
                cacheHelper.removeData(key: 'name');
                cacheHelper.removeData(key: 'email');
                cacheHelper.removeData(key: 'image');
                BlocProvider.of<BotNavBarCubit>(context).resetIndex();
              }
              if (state is LogoutLoading) {
                Navigator.pop(context);
                HelperMethods.showLoadingAlertDialog(context);
              }
              if (state is LogoutFailed) {
                Navigator.pop(context);
                HelperMethods.showCustomSnackBarError(
                  context,
                  ErrorMessages.errorMessage(state.error),
                );
              }
            },
            listenWhen: (context, state) =>
                state is LogoutFailed ||
                state is LogoutSuccess ||
                state is LogoutLoading,
            child: Column(
              children: [
                const SettingHeader(),
                SizedBox(height: 48.h),
                SettingsContainer(
                  icon: Assets.svgsSettingsPassChange,
                  title: 'تغيير كلمة المرور',
                  showBackIcon: true,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.newPassword);
                  },
                ),
                SizedBox(height: 16.h),
                SettingsContainer(
                  icon: Assets.svgsSettingsRate,
                  title: 'تقييم التطبيق',
                  showBackIcon: false,
                  onTap: () {
                    HelperMethods.showCustomSnackBarSuccess(
                        context, 'قادم قريبا');
                  },
                ),
                SizedBox(height: 16.h),
                SettingsContainer(
                  icon: Assets.svgsSettingsLogout,
                  title: 'تسجيل الخروج',
                  showBackIcon: false,
                  onTap: () {
                    HelperMethods.showLogoutAlertDialog(
                      context,
                      () {
                        BlocProvider.of<SettingsCubit>(context)
                            .logout(AppConstants.logout);
                      },
                    );
                  },
                ),
                SizedBox(height: 34.h),
                Divider(thickness: 1.h, color: Colors.grey[300]),
                SizedBox(height: 34.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColorofNavBar,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'يمكنك متابعة صفحاتنا علي',
                          style: AppTextStyles.cairo16SemiBoldBlack
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse(
                                      'https://www.facebook.com/profile.php?id=61558999236242&mibextid=ZbWKwL'),
                                  mode: LaunchMode.platformDefault,
                                  browserConfiguration:
                                      const BrowserConfiguration(
                                    showTitle: true,
                                  ),
                                );
                              },
                              child: SvgPicture.asset(Assets.iconsIconFacebook),
                            ),
                            SizedBox(width: 16.w),
                            InkWell(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse(
                                      'https://www.instagram.com/nourish.me10/?igsh=MWhnam56d21xZ2YyeA%3D%3D'),
                                  mode: LaunchMode.platformDefault,
                                  browserConfiguration:
                                      const BrowserConfiguration(
                                    showTitle: true,
                                  ),
                                );
                              },
                              child:
                                  SvgPicture.asset(Assets.iconsIconInstagram),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
