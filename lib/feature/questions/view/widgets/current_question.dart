import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';

import '../../../../core/theme/app_colors.dart';

class CurrentQuestion extends StatelessWidget {
  final int index;
  const CurrentQuestion({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          5,
          (index) {
            return Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: index <= this.index
                    ? AppColors.mainColor
                    : AppColors.currentQuestionColor,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        ),
      ),
    );
  }
}
