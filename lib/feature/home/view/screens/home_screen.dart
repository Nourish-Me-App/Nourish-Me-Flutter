import 'package:nourish_me/core/imports/questions_screen_imports.dart';
import 'package:nourish_me/feature/home/view/widgets/custom_container.dart';

import '../widgets/custom_container_user_personal_info.dart';
import '../widgets/custom_user_mass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'النتائج',
          style: AppTextStyles.cairo12ExtraBoldTFFContentColor.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0.w, bottom: 10.0.w, right: 10.0.h),
          child: SvgPicture.asset(
            "assets/svgs/app_logo.svg",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
        child: ListView(
          children: [
            Column(
              children: [
                SvgPicture.asset(Assets.svgsresultpage),
                CustomContainerUserInfo(
                  titleOne: '25 Years',
                  titleTwo: '180 cm',
                  titleThree: '70 kg',
                  svgPathOne: SvgPicture.asset(Assets.svgsVectorResultpageicon),
                  svgPathTwo: SvgPicture.asset(Assets.svgsHeightresultpageicon),
                  svgPathThree: SvgPicture.asset(Assets.svgsWeightResultpageicon),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomContainer(
                    title: 'السعرات الحراريه',
                    svgPath: SvgPicture.asset(Assets.svgsCaloriesResultpageicon),
                    result: '2500 cal'),
                SizedBox(
                  height: 15.h,
                ),
                CustomUserMass(
                  title: 'نوع النظام',
                  svgPath: SvgPicture.asset(Assets.svgsVectorResultpageicon),
                  resultOne: '33',
                  resultTwo: 'سمنه مرحله اولى',
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomContainer(
                  result: 'low carb high protein',
                  svgPath:
                  SvgPicture.asset(Assets.svgsspatulaspoonResultpageicon),
                  title: 'نوع النظام ',
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomContainer(
                  result: '2 liter',
                  svgPath: SvgPicture.asset(Assets.svgsVectorResultpageicon),
                  title: 'الماء',
                )
              ],
            ),
          ],

        ),
      ),
    );
  }
}
