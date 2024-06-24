import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
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
                cacheHelper.deleteSecuredData(key: 'name');
                cacheHelper.deleteSecuredData(key: 'email');
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
