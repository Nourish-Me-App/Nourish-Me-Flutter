import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/error_body.dart';
import '../../../home/view/widgets/no_internet_connection.dart';
import '../../data/models/diets_model.dart';
import '../../logic/cubit/diets_cubit.dart';
import '../widgets/diets_card.dart';
import '../widgets/diets_loading.dart';
import '../widgets/separator.dart';
import '../widgets/tab_bar.dart';

class DietsScreen extends StatelessWidget {
  const DietsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> whatToEat = [
      'الافطار',
      'وجبة خفيفة',
      'الغداء',
      'وجبة خفيفة',
      'العشاء'
    ];
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return child;
        } else {
          return const NoInternetConnection();
        }
      },
      child: DefaultTabController(
        length: 7,
        initialIndex: 0,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<DietsCubit, DietsState>(
            builder: (context, state) {
              if (state is DietsSuccessState) {
                Meals? meals = state.dietsModel.data!.diet!.meals;
                List<Day?> days = [
                  meals!.saturday,
                  meals.sunday,
                  meals.monday,
                  meals.tuesday,
                  meals.wednesday,
                  meals.thursday,
                  meals.friday,
                ];
                return Scaffold(
                  appBar: MyAppBar(
                    title:
                        'نظام ${state.dietsModel.data!.diet!.calories} سعر حراري',
                    bottom: const MyTabBar(),
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(right: 24.w, left: 30.w),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        7,
                        (index) {
                          Day? currentDay = days[index];
                          List<List<String>?> meals = [
                            currentDay!.breakfast,
                            currentDay.firstSnack!.split('+'),
                            currentDay.lunch,
                            currentDay.secondSnack!.split('+'),
                            currentDay.dinner,
                          ];
                          return ListView.separated(
                            itemBuilder: (context, itemIndex) {
                              if (itemIndex == 0) {
                                return DietsSeparator(whatToEat: whatToEat[0]);
                              } else {
                                return SizedBox(
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        VerticalDivider(
                                          width: 10.w,
                                          thickness: 2.w,
                                          color: AppColors.dividerColor,
                                        ),
                                        SizedBox(width: 8.w),
                                        DietsCard(
                                          meals: meals,
                                          index: itemIndex - 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            separatorBuilder: (context, itemIndex) {
                              if (itemIndex == 0) {
                                return const SizedBox();
                              } else {
                                return DietsSeparator(
                                    whatToEat: whatToEat[itemIndex]);
                              }
                            },
                            itemCount: 6,
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              if (state is DietsFailureState) {
                return ErrorBody(
                  buttonAction: () async {
                    await BlocProvider.of<DietsCubit>(context)
                        .fetchDietMeals(AppConstants.diet);
                  },
                );
              } else {
                return Shimmer.fromColors(
                  baseColor: AppColors.dietContainerColor,
                  highlightColor: Colors.grey[200]!,
                  child: const DietsLoading(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
