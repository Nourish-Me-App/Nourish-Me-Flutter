import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/cubit/auth_cubit.dart';

import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/tff_label.dart';

class NameRow extends StatelessWidget {
  const NameRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Expanded(
          child: Column(
            children: [
              const TFFLabel(label: 'الإسم الأول'),
              SizedBox(height: 8.h),
              CustomTFF(
                hintText: 'أدخل الإسم الأول',
                kbType: TextInputType.name,
                controller: authCubit.firstNameController,
                validate: (value) {
                  return ValidationErrorTexts.firstNameValidation(value);
                },
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            children: [
              const TFFLabel(label: 'الإسم الأخير'),
              SizedBox(height: 8.h),
              CustomTFF(
                hintText: 'أدخل الإسم الأخير',
                kbType: TextInputType.name,
                controller: authCubit.lastNameController,
                validate: (value) {
                  return ValidationErrorTexts.lastNameValidation(value);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
