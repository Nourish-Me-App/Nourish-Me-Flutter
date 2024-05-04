import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_me/feature/diets/view/widgets/tab_bar.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class DietsScreen extends StatefulWidget {
  const DietsScreen({super.key});

  @override
  State<DietsScreen> createState() => _DietsScreenState();
}

class _DietsScreenState extends State<DietsScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> whatToEat = ['وجبة خفيفة', 'الغداء', 'وجبة خفيفة', 'العشاء'];
    return DefaultTabController(
      length: 7,
      initialIndex: 0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const MyAppBar(
            // Todo: change title
            title: 'نظام 1000 سعر حراري',
            bottom: MyTabBar(),
          ),
          body: Padding(
            padding: EdgeInsets.only(right: 24.w, left: 30.w),
            child: TabBarView(
              children: List.generate(
                7,
                (index) => Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'الافطار',
                            style: AppTextStyles.cairo18BoldBlack
                                .copyWith(fontSize: 16.sp),
                          ),
                          SizedBox(width: 8.w),
                          CircleAvatar(
                            radius: 5.r,
                            backgroundColor: AppColors.mainColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => SizedBox(
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                VerticalDivider(
                                  width: 10.w,
                                  thickness: 2.w,
                                  color: AppColors.dividerColor,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 20.h),
                                    margin: index != 4
                                        ? EdgeInsets.only(
                                            top: 8.h, bottom: 16.h)
                                        : EdgeInsets.symmetric(vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.dietContainerColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35.r),
                                        bottomLeft: Radius.circular(20.r),
                                        bottomRight: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r),
                                      ),
                                    ),
                                    child: Column(
                                      children: List.generate(
                                        5,
                                        (index) => Row(
                                          children: [
                                            SizedBox(
                                              width: 35.w,
                                              height: 35.h,
                                              child: Card(
                                                elevation: 0,
                                                surfaceTintColor: Colors.white,
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    Assets
                                                        .svgsMealsChocolateBar,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Text(
                                                'نصف رغيف خبز اسمر او بلدي او 2 توست اسمر',
                                                style: AppTextStyles
                                                    .cairo12RegularBlack
                                                    .copyWith(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                whatToEat[index],
                                style: AppTextStyles.cairo18BoldBlack
                                    .copyWith(fontSize: 16.sp),
                              ),
                              SizedBox(width: 8.w),
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: AppColors.mainColor,
                              ),
                            ],
                          ),
                        ),
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
