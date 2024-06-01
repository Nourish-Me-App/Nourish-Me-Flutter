import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DietsCard extends StatelessWidget {
  final int index;
  final List<List<String>?> meals;
  const DietsCard({
    super.key,
    required this.index,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        margin: index != 4
            ? EdgeInsets.only(top: 8.h, bottom: 16.h)
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
            meals[index]!.length,
            (index) {
              return meals[this.index]![index].trim() != ''
                  ? Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          height: 35.h,
                          child: Card(
                            elevation: 0,
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Image.asset(
                                HelperMethods.getMealImage(
                                    meals[this.index]![index]),
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            meals[this.index]![index],
                            style: AppTextStyles.cairo12RegularBlack.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }
}
