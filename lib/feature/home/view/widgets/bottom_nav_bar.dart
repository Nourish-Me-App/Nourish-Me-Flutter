import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourish_me/core/helpers/app_constants.dart';
import 'package:nourish_me/feature/home/data/repository/home_repository.dart';
import 'package:nourish_me/feature/home/logic/cubit/home_cubit.dart';
import '../../../../core/networking/dio_handler.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../diets/view/screen/diets_screen.dart';
import '../../../settings/data/repositories/logout_repo.dart';
import '../../../settings/logic/cubit/settings_cubit.dart';
import '../../../settings/view/screens/settings.dart';
import '../../../workout/view/screens/work_out.dart';
import '../screens/home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int selectedIndex = 0;
List pages = [
  BlocProvider(
    create: (context) => HomeCubit(
      HomeRepo(DioHandler()),
    )..fetchHomeData(AppConstants.home),
    child: const HomeScreen(),
  ),
  const DietsScreen(),
  const WorkOutScreen(),
  BlocProvider<SettingsCubit>(
    create: (context) => SettingsCubit(LogoutRepo(DioHandler())),
    child: const SettingsScreen(),
  ),
];

class _BottomNavState extends State<BottomNav> {
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        height: 67.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.backGroundColorofNavBar,
            elevation: 0.0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: selectedIndex == 0
                    ? SvgPicture.asset(Assets.svgsResultsHomeiconselected)
                    : SvgPicture.asset(Assets.svgsResultsHomeicon),
                label: 'النتائج',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 1
                    ? SvgPicture.asset(Assets.svgsResultsTableSelected)
                    : SvgPicture.asset(Assets.svgsResultsTable),
                label: 'الوجبات',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 2
                    ? SvgPicture.asset(Assets.svgsResultsWeightSelected)
                    : SvgPicture.asset(Assets.svgsResultsWeightlift),
                label: 'التمارين',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 3
                    ? SvgPicture.asset(Assets.svgsResultsSettingsSelected)
                    : SvgPicture.asset(Assets.svgsResultsSettings),
                label: 'الاعدادات',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.black,
            unselectedLabelStyle:
                AppTextStyles.cairosemibold14maincolor.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
            selectedLabelStyle: AppTextStyles.cairosemibold14maincolor.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
