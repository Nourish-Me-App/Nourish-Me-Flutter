import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/model/home_model.dart';
import '../../logic/cubit/home_cubit.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_container_user_personal_info.dart';
import '../widgets/custom_user_mass.dart';
import '../widgets/shimmer_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'النتائج'),
      body: SafeArea(
        child: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return child;
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.signal_wifi_off, size: 80),
                    const SizedBox(height: 20),
                    Text(
                      'لا يوجد اتصال بالإنترنت',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const ShimmerLoadingHome();
                } else if (state is HomeFailureState) {
                  return Center(
                      child: Text('Failed to load data: ${state.error}'));
                } else if (state is HomeSuccessState) {
                  HomeModel homeModel = state.homeModel;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SvgPicture.asset(Assets.svgsResultsResults),
                        SizedBox(height: 32.h),
                        CustomContainerUserInfo(
                          titleOne: '${homeModel.data!.ageInYears} years',
                          titleTwo: '${homeModel.data!.heightInCM} cm',
                          titleThree: '${homeModel.data!.weightInKG} kg',
                          svgPathOne: SvgPicture.asset(Assets.svgsResultsAge),
                          svgPathTwo: SvgPicture.asset(
                              Assets.svgsResultsGuidanceGuestHeightLimit),
                          svgPathThree: SvgPicture.asset(
                              Assets.svgsResultsIconParkOutlineWeight),
                        ),
                        SizedBox(height: 15.h),
                        CustomContainer(
                          title: 'السعرات الحرارية',
                          svgPath: SvgPicture.asset(
                              Assets.svgsResultsFluentMdl2Calories),
                          result: '${homeModel.data!.totalCalories} cal',
                        ),
                        SizedBox(height: 15.h),
                        CustomUserMass(
                          title: 'مؤشر كتلة الجسم ',
                          svgPath: SvgPicture.asset(Assets.svgsResultsVector),
                          resultOne: '${homeModel.data!.massIndex}',
                          resultTwo: '${homeModel.data!.massIndex}',
                        ),
                        SizedBox(height: 15.h),
                        CustomContainer(
                          result: '${homeModel.data!.dietType}',
                          svgPath: SvgPicture.asset(
                              Assets.svgsResultsFluentSpatulaSpoon16Regular),
                          title: 'نوع النظام ',
                        ),
                        SizedBox(height: 15.h),
                        CustomContainer(
                          result: '${homeModel.data!.waterAmount}',
                          svgPath:
                              SvgPicture.asset(Assets.svgsResultsWaterdrop),
                          title: 'الماء',
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
