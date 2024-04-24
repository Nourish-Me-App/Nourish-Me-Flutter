import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/imports/verification_screen_imports.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoarding = context.watch<OnBoardingCubit>();
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is GoHomeState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushNamed(context, Routes.signUpScreen);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                context.read<OnBoardingCubit>().transition();
              },
              child: Text(
                onBoarding.currentIndex == onBoarding.onBoardingList.length - 1
                    ? 'ابدأ'
                    : 'تخطي',
                style: AppTextStyles.cairo16boldtextcolorOnboarding,
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      SvgPicture.asset(
                        onBoarding.onBoardingList[index].image,
                        height: 483.h,
                      ),
                      SizedBox(
                        height: 84.h,
                        width: 319.w,
                        child: Text(
                          textAlign: TextAlign.right,
                          onBoarding.onBoardingList[index].description,
                          style: AppTextStyles.cairo15normaltextcolorOnboarding,
                        ),
                      )
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          onBoarding.onBoardingList.length,
                          (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.bounceInOut,
                                width:
                                    index == onBoarding.currentIndex ? 18 : 8,
                                height: 8,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: index == onBoarding.currentIndex
                                      ? AppColors.mainColor
                                      : AppColors.swipColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              )),
                    ),
                  ),
                ],
              ),
              onPageChanged: (value) {
                context.read<OnBoardingCubit>().changePage(value);
              },
              itemCount: onBoarding.onBoardingList.length,
              controller: context.read<OnBoardingCubit>().pageController,
            ))
          ],
        )),
      ),
    );
  }
}
