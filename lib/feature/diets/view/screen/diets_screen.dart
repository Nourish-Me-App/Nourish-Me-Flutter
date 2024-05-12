import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/tab_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/diets_card.dart';
import '../widgets/separator.dart';

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
    return DefaultTabController(
      length: 7,
      initialIndex: 0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const MyAppBar(
            title: 'نظام 1000 سعر حراري',
            bottom: MyTabBar(),
          ),
          body: Padding(
            padding: EdgeInsets.only(right: 24.w, left: 30.w),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                7,
                (index) => ListView.separated(
                  itemBuilder: (context, itemIndex) {
                    if (itemIndex == 0) {
                      return DietsSeparator(whatToEat: whatToEat[0]);
                    } else {
                      return SizedBox(
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
                              DietsCard(
                                title: 'خضار',
                                index: itemIndex,
                                numberOfFood: itemIndex,
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
                      return DietsSeparator(whatToEat: whatToEat[itemIndex]);
                    }
                  },
                  itemCount: 6,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
