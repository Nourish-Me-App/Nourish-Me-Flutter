import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/helpers/helper_methods.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/feature/diets/view/widgets/tab_bar.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';
import 'package:nourish_me/feature/workout/logic/cubit/workout_cubit.dart';
import 'details_screen.dart';
import '../widgets/item_card.dart';
import '../widgets/workout_app_bar.dart';

class WorkOutScreen extends StatelessWidget {
  const WorkOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WorkoutFailureState) {
          return Center(child: Text('Failed to load: ${state.error}'));
        } else if (state is WorkoutSuccessState) {
          final exercises = state.workoutModel.data?.exercises ?? [];
          List<Exercises> saturday =
              HelperMethods.setDaysExercises('saturday', exercises);
          List<Exercises> sunday =
              HelperMethods.setDaysExercises('sunday', exercises);
          List<Exercises> monday =
              HelperMethods.setDaysExercises('monday', exercises);
          List<Exercises> tuesday =
              HelperMethods.setDaysExercises('tuesday', exercises);
          List<Exercises> wednesday =
              HelperMethods.setDaysExercises('wednesday', exercises);
          List<Exercises> thursday =
              HelperMethods.setDaysExercises('thursday', exercises);
          List<Exercises> friday =
              HelperMethods.setDaysExercises('friday', exercises);
          log(saturday.toString());
          log(sunday.toString());
          log(monday.toString());
          log(tuesday.toString());
          log(wednesday.toString());
          log(thursday.toString());
          log(friday.toString());
          final List<List<Exercises>> exercise = [
            saturday,
            sunday,
            monday,
            tuesday,
            wednesday,
            thursday,
            friday
          ];

          return DefaultTabController(
            length: 7,
            initialIndex: 0,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar:
                    const MyAppBarWorkOut(title: 'تمرين', bottom: MyTabBar()),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(7, (pageIndex) {
                    if (exercise[pageIndex][0].name == 'Break' ||
                        exercise[pageIndex][0].name == 'break') {
                      return Column(
                        children: [
                          SvgPicture.asset(Assets.svgsResultsBreak),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'لا يوجد تمارين اليوم',
                            style:
                                AppTextStyles.cairo12ExtraBoldTFFContentColor,
                          )
                        ],
                      );
                      
                    }else {
                      return ListView.builder(
                        itemCount: exercise[pageIndex].length,
                        itemBuilder: (context, index) {
                          return ItemCard(
                            title: exercise[pageIndex][index].name!,
                            time: exercise[pageIndex][index].type!,
                            image: exercise[pageIndex][index].image??'',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    currentIndex: index,
                                    item: exercise[pageIndex],
                                    length: exercise[pageIndex].length,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('Unhandled state'));
        }
      },
    );
  }
}
