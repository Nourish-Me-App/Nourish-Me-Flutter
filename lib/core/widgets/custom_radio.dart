import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomRadio extends StatefulWidget {
  final int value;
  final int? groupValue;
  final String answer;
  final void Function(int) onChanged;
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.answer,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.answer,
              style: AppTextStyles.cairo16SemiBoldBlack
                  .copyWith(fontWeight: FontWeight.normal),
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
