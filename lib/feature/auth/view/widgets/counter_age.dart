import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nourish_me/feature/auth/logic/cubit/data_screen_cubit.dart';
import 'dart:developer';

import '../../../../core/imports/app_routes_imports.dart';
import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class CounterAge extends StatefulWidget {
  const CounterAge({super.key});

  @override
  State<CounterAge> createState() => _CounterAgeState();
}

class _CounterAgeState extends State<CounterAge> {
  late TextEditingController _ageController;
  late DataScreenCubit dataScreenCubit;
  bool _isSnackBarShown = false;
  Timer? _timerAge;

  @override
  void initState() {
    super.initState();
    dataScreenCubit = BlocProvider.of<DataScreenCubit>(context);
    _ageController =
        TextEditingController(text: dataScreenCubit.ageCounter.toString());
    _ageController.addListener(_handleAgeChange);
  }

  void startAgeIncreament() {
    _timerAge = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (dataScreenCubit.ageCounter < 80) {
        dataScreenCubit.increamnetAge();
      } else {
        stopTimerAge();
      }
      _ageController.text = dataScreenCubit.ageCounter.toString();
    });
  }

  void startAgeDecreament() {
    _timerAge = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (dataScreenCubit.ageCounter > 12) {
        dataScreenCubit.decrementAge();
      } else {
        stopTimerAge();
      }
      _ageController.text = dataScreenCubit.ageCounter.toString();
    });
  }

  void stopTimerAge() {
    _timerAge?.cancel();
  }

  void _handleAgeChange() {
    String text = _ageController.text;
    if (text.isEmpty) {
      _showSnackBar("برجاء ادخال العمر");
    } else {
      int? newValue = int.tryParse(text);
      if (newValue != null) {
        if (newValue >= 12 || newValue <= 80) {
          dataScreenCubit.updateAge(newValue);
        } else {
          _showSnackBar("العمر يجب ان يكون بين 12 و 80");
        }
      }
    }
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
    _ageController.removeListener(_handleAgeChange);
    _ageController.dispose();
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
            onLongPressStart: (_) {
              log("onLongPressStart");
              startAgeIncreament();
            },
            onLongPressEnd: (_) {
              log("onLongPressEnd");
              stopTimerAge();
            },
            onTap: () {
              log("incrementAge");
              dataScreenCubit.increamnetAge();
              _ageController.text = dataScreenCubit.ageCounter.toString();
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
              cursorColor: AppColors.mainColor,
              controller: _ageController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: AppTextStyles.cairo24Boldmaincolor,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'برجاء ادخال العمر';
                }
                int? newValue = int.tryParse(value);
                if (newValue == null || newValue < 12 || newValue > 80) {
                  return 'العمر يجب ان يكون بين 12 و 80';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (Form.of(context).validate()) {
                  _showSnackBar('العمر يجب ان يكون بين 12 و 80');
                  _ageController.text = dataScreenCubit.ageCounter.toString();
                } else {
                  int newValue = int.parse(value);
                  dataScreenCubit.updateAge(newValue);}
              },
            ),
          ),
          GestureDetector(
            onLongPressStart: (_) {
              log("onLongPressStart");
              startAgeDecreament();
            },
            onLongPressEnd: (_) {
              log("onLongPressEnd");
              stopTimerAge();
            },
            onTap: () {
              log("decrementAge");
              dataScreenCubit.decrementAge();
              _ageController.text = dataScreenCubit.ageCounter.toString();
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
