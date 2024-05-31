import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../logic/on_boarding_cubit.dart';
import '../widgets/text.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

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
              appBar: AppBar(),
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
                                            child: Image.asset(
                                          onBoarding.onBoardingList[i].image,
                                          fit: BoxFit.cover,
                                        )),
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
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 15, top: 22),
                          child: CustomButton(
                            buttonStyle: AppTextStyles.cairo16BoldWhite,
                            color: AppColors.mainColor,
                            buttonText: onBoarding.currentIndex ==
                                    onBoarding.onBoardingList.length - 1
                                ? 'أبدأ'
                                : 'التالى',
                            buttonAction: () {
                              context.read<OnBoardingCubit>().transition();
                            },
                          ),
                        ),
                        onBoarding.currentIndex ==
                                onBoarding.onBoardingList.length - 1
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 35),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 35.h,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 35),
                                child: CustomBorderButton(
                                  buttonText: 'أبدأ',
                                  buttonStyle:
                                      AppTextStyles.cairo16BoldMainColor,
                                  buttonAction: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              Routes.signUpScreen);
                                    });
                                  },
                                ),
                              )
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
