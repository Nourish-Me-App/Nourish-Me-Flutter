import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';

class CustomRadio extends StatefulWidget {
  final int value;
  final String gender;
  final String imge;
  final int? groupValue;
  final void Function(int) onChanged;
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.gender,
    required this.imge,
  });

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: () => widget.onChanged(widget.value),
        child: Column(
          children: [
            SvgPicture.asset(widget.imge),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.gender,
              style: AppTextStyles.cairo16SemiBoldBlack,
            ),
            SizedBox(width: 10.w),
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : Colors.grey[200],
                border: selected
                    ? Border.all(color: AppColors.mainColor, width: 2)
                    : Border.all(color: AppColors.radioBorderColor, width: 2),
              ),
              child: Center(
                child: selected
                    ? const Icon(
                        Icons.circle,
                        size: 12,
                        color: AppColors.mainColor,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
