import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class DietsLoading extends StatelessWidget {
  const DietsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      child: Column(
        children: [
          Container(
            height: 24.h,
            width: 124.w,
            decoration: BoxDecoration(
              color: AppColors.dietContainerColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, itemIndex) {
                if (itemIndex == 0) {
                  return Container(
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: AppColors.dietContainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                } else {
                  return Container(
                    height: itemIndex == 0 ? 60.h : itemIndex * 60.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    margin: itemIndex != 4
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
                  );
                }
              },
              separatorBuilder: (context, itemIndex) {
                if (itemIndex == 0) {
                  return const SizedBox();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: AppColors.dietContainerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
