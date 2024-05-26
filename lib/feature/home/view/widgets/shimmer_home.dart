import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingHome extends StatelessWidget {
  const ShimmerLoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 282.0.h,
          ),
          SizedBox(height: 15.0.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 50.0.h,
          ),
          SizedBox(height: 15.0.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 50.0.h,
          ),
          SizedBox(height: 15.0.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 50.0.h,
          ),
          SizedBox(height: 15.0.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 50.0.h,
          ),
          SizedBox(height: 15.0.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 50.0.h,
          ),
        ],
      ),
    );
  }
}
