import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourish_me/feature/auth/logic/cubit/data_screen_cubit.dart';

import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HeightCounter extends StatefulWidget {
  const HeightCounter({super.key});

  @override
  State<HeightCounter> createState() => _HeightCounterState();
}

class _HeightCounterState extends State<HeightCounter> {
  late TextEditingController _heightController;
  late DataScreenCubit dataScreenCubit;
  bool _isSnackBarShown = false;
  Timer? _timerHeight;

  @override
  void initState() {
    super.initState();
    dataScreenCubit = BlocProvider.of<DataScreenCubit>(context);
    _heightController =
        TextEditingController(text: dataScreenCubit.heightCounter.toString());
    _heightController.addListener(_handleheightChange);
  }

  void _handleheightChange() {
    String text = _heightController.text;
    int? newValue = int.tryParse(text);
    if (newValue != null) {
      if (newValue >= 140 || newValue <= 210) {
        dataScreenCubit.updateHeight(newValue);
      } else {
        _showSnackBar('cm الطول يجب أن يكون بين 140 و 210');
      }
    }
  }

  void startIncreaseHeight() {
    _timerHeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (dataScreenCubit.heightCounter < 210) {
        dataScreenCubit.incrementHeight();
      } else {
        stopTimerHeight();
      }
      _heightController.text = dataScreenCubit.heightCounter.toString();
    });
  }

  void startDecreaseHeight() {
    _timerHeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (dataScreenCubit.heightCounter > 140) {
        dataScreenCubit.decrementHeight();
      } else {
        stopTimerHeight();
      }
      _heightController.text = dataScreenCubit.heightCounter.toString();
    });
  }

  void stopTimerHeight() {
    _timerHeight?.cancel();
  }

  void _showSnackBar(String message) {
    if (!_isSnackBarShown) {
      _isSnackBarShown = true;
      HelperMethods.showCustomSnackBarError(context, message);
      Future.delayed(const Duration(seconds: 3), () {
        _isSnackBarShown = false;
      });
    }
  }

  @override
  void dispose() {
    _heightController.removeListener(_handleheightChange);
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.h,
      decoration: BoxDecoration(
        color: AppColors.counterColor,
        border: Border.all(color: AppColors.counterColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onLongPressStart: (_) => startIncreaseHeight(),
            onLongPressEnd: (_) => stopTimerHeight(),
            onTap: () {
              dataScreenCubit.incrementHeight();
              _heightController.text = dataScreenCubit.heightCounter.toString();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 60.w,
            child: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(3)],
              cursorColor: AppColors.mainColor,
              controller: _heightController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: AppTextStyles.cairo24Boldmaincolor,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                if (Form.of(context).validate()) {
                  int.tryParse(value) == null
                      ? null
                      : int.parse(value) < 140 || int.parse(value) > 210
                          ? _showSnackBar('cm الطول يجب أن يكون بين 140 و 210')
                          : null;
                  _heightController.text =
                      dataScreenCubit.heightCounter.toString();
                } else {
                  int newValue = int.parse(value);
                  dataScreenCubit.updateHeight(newValue);
                }
              },
            ),
          ),
          GestureDetector(
            onLongPressStart: (_) => startDecreaseHeight(),
            onLongPressEnd: (_) => stopTimerHeight(),
            onTap: () {
              dataScreenCubit.decrementHeight();
              _heightController.text = dataScreenCubit.heightCounter.toString();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
