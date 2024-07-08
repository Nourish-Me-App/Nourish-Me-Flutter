import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourish_me/feature/home/view/widgets/blood_pressure_widgets.dart';
import 'package:nourish_me/feature/home/view/widgets/blood_suger_widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/error_body.dart';
import '../../data/model/home_model.dart';
import '../../logic/home/home_cubit.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_container_user_personal_info.dart';
import '../widgets/custom_user_mass.dart';
import '../../../../core/widgets/no_internet_connection.dart';
import '../widgets/shimmer_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state is HomeLoadingState
              ? _buildShimmerAppBar()
              : const MyAppBar(title: 'النتائج'),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: OfflineBuilder(
                    connectivityBuilder: (
                      BuildContext context,
                      ConnectivityResult connectivity,
                      Widget child,
                    ) {
                      final bool connected =
                          connectivity != ConnectivityResult.none;
                      if (connected) {
                        return child;
                      } else {
                        return const NoInternetConnection();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Builder(
                        builder: (context) {
                          if (state is HomeLoadingState) {
                            return const ShimmerLoadingHome();
                          } else if (state is HomeFailureState) {
                            return ErrorBody(
                              buttonAction: () async {
                                await BlocProvider.of<HomeCubit>(context)
                                    .fetchHomeData(AppConstants.home);
                              },
                            );
                          } else if (state is HomeSuccessState) {
                            HomeModel homeModel = state.homeModel;
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SvgPicture.asset(Assets.svgsResultsResults),
                                  SizedBox(height: 32.h),
                                  CustomContainerUserInfo(
                                    titleOne:
                                        '${homeModel.data!.ageInYears} years',
                                    titleTwo:
                                        '${homeModel.data!.heightInCM} cm',
                                    titleThree:
                                        '${homeModel.data!.weightInKG} kg',
                                    svgPathOne:
                                        SvgPicture.asset(Assets.svgsResultsAge),
                                    svgPathTwo: SvgPicture.asset(Assets
                                        .svgsResultsGuidanceGuestHeightLimit),
                                    svgPathThree: SvgPicture.asset(Assets
                                        .svgsResultsIconParkOutlineWeight),
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomContainer(
                                    title: 'السعرات الحرارية',
                                    svgPath: SvgPicture.asset(
                                        Assets.svgsResultsFluentMdl2Calories),
                                    result:
                                        '${homeModel.data!.totalCalories} cal',
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomUserMass(
                                    title: 'مؤشر كتلة الجسم ',
                                    svgPath: SvgPicture.asset(
                                        Assets.svgsResultsVector),
                                    resultOne: '${homeModel.data!.massIndex}',
                                    resultTwo: HelperMethods.calculateBMI(
                                        homeModel.data!.massIndex),
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomContainer(
                                    result: '${homeModel.data!.dietType}',
                                    svgPath: SvgPicture.asset(Assets
                                        .svgsResultsFluentSpatulaSpoon16Regular),
                                    title: 'نوع النظام ',
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomContainer(
                                    result: '${homeModel.data!.waterAmount}',
                                    svgPath: SvgPicture.asset(
                                        Assets.svgsResultsWaterdrop),
                                    title: 'الماء',
                                  ),
                                  SizedBox(height: 15.h),
                                  const BloodPressureWidgets(),
                                  SizedBox(height: 15.h),
                                  const BloodSugerWidgets(),
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
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildShimmerAppBar() {
    return AppBar(
      title: Shimmer.fromColors(
        baseColor: AppColors.dietContainerColor,
        highlightColor: Colors.grey[200]!,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.dietContainerColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          width: 150.w,
          height: 24.h,
        ),
      ),
      centerTitle: true,
    );
  }
}
