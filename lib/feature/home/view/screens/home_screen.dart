import 'package:nourish_me/core/widgets/custom_app_bar.dart';

import '../../../../core/imports/questions_screen_imports.dart';
import '../widgets/custom_container.dart';

import '../widgets/custom_container_user_personal_info.dart';
import '../widgets/custom_user_mass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'النتائج'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SvgPicture.asset(Assets.svgsResultsResultPage),
                  CustomContainerUserInfo(
                    titleOne: '25 Years',
                    titleTwo: '180 cm',
                    titleThree: '70 kg',
                    svgPathOne: SvgPicture.asset(Assets.svgsResultsCilChild),
                    svgPathTwo: SvgPicture.asset(
                        Assets.svgsResultsGuidanceGuestHeightLimit),
                    svgPathThree: SvgPicture.asset(
                        Assets.svgsResultsIconParkOutlineWeight),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomContainer(
                    title: 'السعرات الحرارية',
                    svgPath:
                        SvgPicture.asset(Assets.svgsResultsFluentMdl2Calories),
                    result: '2500 cal',
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomUserMass(
                    title: 'مؤشر كتلة الجسم ',
                    svgPath: SvgPicture.asset(Assets.svgsResultsVector),
                    resultOne: '33',
                    resultTwo: 'سمنه مرحله اولى',
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomContainer(
                    result: 'low carb high protein',
                    svgPath: SvgPicture.asset(
                        Assets.svgsResultsFluentSpatulaSpoon16Regular),
                    title: 'نوع النظام ',
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomContainer(
                    result: '2 liter',
                    svgPath: SvgPicture.asset(Assets.svgsResultsWaterdrop),
                    title: 'الماء',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
