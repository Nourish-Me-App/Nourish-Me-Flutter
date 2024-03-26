import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({
    super.key,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(left: 8.w, right: 1.w),
      constraints: BoxConstraints.tight(
        Size.square(18.r),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        color: _isChecked ? AppColors.mainColor : AppColors.checkBoxColor,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
          });
        },
        child: _isChecked
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16.r,
              )
            : null,
      ),
    );
  }
}
