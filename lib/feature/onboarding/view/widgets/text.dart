import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.color,
    this.overflow,
    this.textDirection,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.shadows,
    this.maxLines,
  });
  final String text;
  final Color? color;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<Shadow>? shadows;
  final int? maxLines;

  const TextWidget.bigTitle(
    this.text, {
    super.key,
    this.color = Colors.black,
    this.overflow,
    this.textDirection,
    this.textAlign,
    this.fontSize = 32,
    this.fontWeight = FontWeight.w700,
    this.shadows,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.ellipsis,
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: maxLines,
      style: AppTextStyles.cairo15normaltextcolorOnboarding,
    );
  }
}
