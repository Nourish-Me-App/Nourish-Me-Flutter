import 'package:flutter/material.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';

class TFFLabel extends StatelessWidget {
  final String label;
  const TFFLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: AppTextStyles.cairo16SemiBoldBlack,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
