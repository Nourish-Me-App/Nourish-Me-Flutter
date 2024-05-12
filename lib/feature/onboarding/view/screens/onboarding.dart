import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/imports/questions_screen_imports.dart';
import 'package:nourish_me/core/routing/routes.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/core/widgets/custom_button.dart';
import 'package:nourish_me/feature/onboarding/logic/on_boarding_cubit.dart';
import 'package:nourish_me/feature/onboarding/view/widgets/text.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnBoardingCubit>(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GoHomeState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pushReplacementNamed(Routes.signUpScreen);
              });
            }
            final onBoarding = context.watch<OnBoardingCubit>();
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.signUpScreen);
                    },
                    child: Text(
                      'تخطي',
                      style: AppTextStyles.cairo16BoldMainColor,
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                              controller: onBoarding.pageController,
                              onPageChanged: (page) {
                                context
                                    .read<OnBoardingCubit>()
                                    .changePage(page);
                              },
                              itemCount: onBoarding.onBoardingList.length,
                              itemBuilder: (context, i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SvgPicture.asset(
                                            onBoarding.onBoardingList[i].image,
                                          ),
                                        ),
                                        TextWidget(
                                          onBoarding
                                              .onBoardingList[i].description,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black,
                                          textAlign: TextAlign.center,
                                          maxLines: 5,
                                        ),
                                      ],
                                    ),
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                onBoarding.onBoardingList.length,
                                (index) => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.bounceInOut,
                                      width: index == onBoarding.currentIndex
                                          ? 18
                                          : 8,
                                      height: 8,
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: index == onBoarding.currentIndex
                                            ? AppColors.mainColor
                                            : AppColors.backGroundColorofNavBar,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30.w, right: 30.w, bottom: 15.h, top: 22.h),
                          child: CustomButton(
                            buttonStyle: AppTextStyles.cairo16BoldWhite,
                            buttonText: 'ابدأ',
                            buttonAction: () =>
                                context.read<OnBoardingCubit>().transition(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
