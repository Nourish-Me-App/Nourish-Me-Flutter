import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/imports/app_routes_imports.dart';

import '../../../../core/theme/app_colors.dart';

class CustomQuestionLoading extends StatelessWidget {
  const CustomQuestionLoading({super.key});
  Widget buildLoading({required double width, required double height}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.currentQuestionColor,
      ),
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              buildLoading(width: 185.w, height: 25.h),
              SizedBox(height: 16.h),
              buildLoading(width: 250.w, height: 10.h),
              SizedBox(height: 48.h),
              buildLoading(width: 246.w, height: 220.h),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerRight,
                child: buildLoading(width: 350.w, height: 180.h),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLoading(width: 130.w, height: 30.h),
                  buildLoading(width: 130.w, height: 30.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
