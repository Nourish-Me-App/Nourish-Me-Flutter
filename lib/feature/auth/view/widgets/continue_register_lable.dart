import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class ContinueRegisterLable extends StatelessWidget {
  const ContinueRegisterLable(
      {super.key, required this.name, required this.abbreviation});
  final String name;
  final String abbreviation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$name:', style: AppTextStyles.cairo16SemiBoldBlack),
        Text(abbreviation, style: AppTextStyles.cairosemibold14maincolor),
      ],
    );
  }
}
