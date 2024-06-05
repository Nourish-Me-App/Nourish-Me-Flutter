import 'package:nourish_me/feature/auth/logic/cubit/data_screen_cubit.dart';

import '../../../../core/imports/app_routes_imports.dart';
import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class HeightCounter extends StatefulWidget {
  const HeightCounter({super.key});

  @override
  State<HeightCounter> createState() => _HeightCounterState();
}

class _HeightCounterState extends State<HeightCounter> {
  late TextEditingController _heightController;
  late DataScreenCubit dataScreenCubit;
  bool _isSnackBarShown = false;

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
    if (text.isEmpty) {
      _showSnackBar("برجاء ادخال الطول");
    } else {
      int? newValue = int.tryParse(text);
      if (newValue != null) {
        if (newValue > 140 || newValue < 210) {
          dataScreenCubit.updateHeight(newValue);
        } else {
          _showSnackBar("الطول يجب ان يكون اكبر من او يساوي 160 cm");
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
            onLongPressStart: (_) => dataScreenCubit.startTimerIncreaseHeight(),
            onLongPressEnd: (_) => dataScreenCubit.stopTimerHeight(),
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
              cursorColor: AppColors.mainColor,
              controller: _heightController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: AppTextStyles.cairo24Boldmaincolor,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "برجاء ادخال الطول";
                }
                int? newValue = int.tryParse(value);
                if (newValue == null || newValue < 140 || newValue > 210) {
                  return "الطول يجب ان يكون اكبر من او يساوي 140 cm";
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (Form.of(context).validate()) {
                  _showSnackBar("الطول يجب ان يكون اكبر من او يساوي 140 cm");
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
            onLongPressStart: (_) => dataScreenCubit.startTimerDecreaseHeight(),
            onLongPressEnd: (_) => dataScreenCubit.stopTimerHeight(),
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
