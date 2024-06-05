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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _ageController = TextEditingController(text: authCubit.ageCounter.toString());
    _ageController.addListener(_handleAgeChange);
  }

  void _handleAgeChange() {
    String text = _ageController.text;
    if (text.isEmpty) {
      _showSnackBar("برجاء ادخال العمر");
    } else {
      int? newValue = int.tryParse(text);
      if (newValue != null) {
        if (newValue >= 12 && newValue <= 80) {
          authCubit.updateAge(newValue);
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
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is IncreamentCounter || current is DecreamentCounter,
      builder: (context, state) {
        if (state is IncreamentCounter || state is DecreamentCounter) {
          _ageController.text = authCubit.ageCounter.toString();
        }
        return Form(
          key: _formKey,
          child: Container(
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
                  onLongPressStart: (_) => authCubit.startTimerIncreaseAge(),
                  onLongPressEnd: (_) => authCubit.stopTimerAge(),
                  onTap: () {
                    authCubit.increamnetAge();
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
                      if (value?.isEmpty ?? true) {
                        return 'برجاء ادخال العمر';
                      } else if (int.tryParse(value!)! < 12) {
                        return 'العمر يجب ان يكون اكبر من او يساوي 12 ';
                      } else if (int.tryParse(value)! > 80) {
                        return 'العمر يجب ان يكون اقل من او يساوي 80 ';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        int newValue = int.parse(value);
                        authCubit.updateAge(newValue);
                      } else {
                        _showSnackBar("العمر يجب ان يكون بين 12 و 80");
                        _ageController.text = authCubit.ageCounter.toString();
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onLongPressStart: (_) => authCubit.startTimerDecreaseAge(),
                  onLongPressEnd: (_) => authCubit.stopTimerAge(),
                  onTap: () {
                    authCubit.decrementAge();
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
          ),
        );
      },
    );
  }
}
