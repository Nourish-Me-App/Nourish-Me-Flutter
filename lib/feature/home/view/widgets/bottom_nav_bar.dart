import 'package:flutter/material.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/imports/questions_screen_imports.dart';

import '../../../meals/view/screen/meal_screen.dart';
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
  const HomeScreen(),
  const MealScreen(),
  const WorkOutScreen(),
  const SettingsScreen(),
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
              topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
        ),
        height: 67.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.backGroundColorofNavBar,
            elevation: 0.0,
            items: <BottomNavigationBarItem>[
               BottomNavigationBarItem(
                icon:  selectedIndex == 0
                    ? SvgPicture.asset(Assets.svgsHomeSelected)
                    : SvgPicture.asset(Assets.svgsHome),
                label: 'النتائج',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 1
                    ? SvgPicture.asset(Assets.svgsTableSelected)
                    : SvgPicture.asset(Assets.svgsTable),
                label: 'الوجبات',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 2
                    ? SvgPicture.asset(Assets.svgsWeightLiftsSelected)
                    : SvgPicture.asset(Assets.svgsWeightLifts),
                label: 'التمارين',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 3
                    ? SvgPicture.asset(Assets.svgsSettingsSelected)
                    : SvgPicture.asset(Assets.svgsSettings),
                label: 'الاعدادات',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: AppColors.mainColor,
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
