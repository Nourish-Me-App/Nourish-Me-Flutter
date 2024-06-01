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
  late AuthCubit authCubit;
  bool _isSnackBarShown = false;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _ageController =
        TextEditingController(text: authCubit.ageCounter.toString());
    _ageController.addListener(_handleWeightChange);
  }

  void _handleWeightChange() {
    String text = _ageController.text;
    if (text.isEmpty) {
      _showSnackBar("برجاء ادخال العمر");
    } else {
      int? newValue = int.tryParse(text);
      if (newValue != null) {
        if (newValue >= 18) {
          authCubit.updateWeight(newValue);
        } else {
          _showSnackBar("سنة الوزن يجب ان يكون اكبر من او يساوي 18 ");
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
    _ageController.removeListener(_handleWeightChange);
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
                onLongPressStart: (_) => authCubit.startTimerDecreaseAge(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.increamnetAge();
                  _ageController.text = authCubit.ageCounter.toString();
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
                      return "برجاء ادخال العمر";
                    }
                    int? newValue = int.tryParse(value);
                    if (newValue == null || newValue < 18) {
                      return "الوزن يجب ان يكون اكبر من او يساوي  18";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (Form.of(context)?.validate() ?? false) {
                      _showSnackBar("العمر يجب ان يكون اكبر من او يساوي 18 ");
                      _ageController.text = authCubit.ageCounter.toString();
                    } else {
                      int newValue = int.parse(value);
                      authCubit.updateAge(newValue);
                    }
                  },
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseAge(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.decrementAge();
                  _ageController.text = authCubit.ageCounter.toString();
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
      },
    );
  }
}
