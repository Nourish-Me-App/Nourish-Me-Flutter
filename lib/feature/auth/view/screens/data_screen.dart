import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/imports/signup_screen_imports.dart';
import 'package:nourish_me/core/imports/verification_screen_imports.dart';
import 'package:nourish_me/feature/auth/data/models/continue_register_model.dart';
import 'package:nourish_me/feature/auth/view/widgets/counter_age.dart';
import 'package:nourish_me/feature/auth/view/widgets/height_counter.dart';

import '../widgets/continue_register_lable.dart';
import '../widgets/custom_radio.dart';
import '../widgets/weightcounters.dart';

class ContinueRegisterScreen extends StatefulWidget {
  const ContinueRegisterScreen({super.key});

  @override
  State<ContinueRegisterScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<ContinueRegisterScreen> {
  String? type;
  int? selectedValue;
  late AuthCubit authCubit;
  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  void setType() {
    if (selectedValue == 1) {
      type = "ذكر";
    } else {
      type = "أنثى";
    }
  }

  @override
  Widget build(BuildContext context) {
    ContinueRegisterModel continueRegisterModel = ContinueRegisterModel();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ContinueRegisterSuccess) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم انشاء الحساب بنجاح');
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginScreen,
            (route) => false,
          );
        }
        if (state is ContinueRegisterFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
            context,
            ErrorMessages.errorMessage(state.error!),
          );
        }
        if (state is ContinueRegisterLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'من فضلك قم بإدخال بياناتك ',
                        style: AppTextStyles.cairo700BoldDataScreen,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomRadio(
                          imge: Assets.male,
                          gender: 'ذكر',
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        CustomRadio(
                          imge: Assets.feMale,
                          gender: 'أنثى',
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('السن:', style: AppTextStyles.cairo16SemiBoldBlack),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CounterAge(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const ContinueRegisterLable(
                      name: 'الوزن',
                      abbreviation: 'kg',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const WeightCounter(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const ContinueRegisterLable(
                      name: 'الطول',
                      abbreviation: 'cm',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const HeightCounter(),
                    SizedBox(
                      height: 60.h,
                    ),
                    CustomButton(
                      buttonText: 'متابعه',
                      buttonStyle: AppTextStyles.cairo16BoldWhite,
                      buttonAction: () async {
                        setType();
                        if (selectedValue == null) {
                          HelperMethods.showCustomSnackBarError(
                              context, 'من فضلك قم بتحدد النوع');
                        } else {
                          await AuthRequests.continueRegister(
                            authCubit: authCubit,
                            continueRegisterModel: continueRegisterModel,
                            email: CacheHelper().getData(key: 'email'),
                            name: CacheHelper().getData(key: 'name'),
                            gender: selectedValue.toString(),
                            age: authCubit.ageCounter.toString(),
                            weight: authCubit.weightCounter.toString(),
                            height: authCubit.heightCounter.toString(),
                            password: CacheHelper().getData(key: 'password'),
                            passwordConfirmation: CacheHelper()
                                .getData(key: 'passwordConfirmation'),
                          ).then((value) {
                            CacheHelper().saveData(
                                key: 'age',
                                value: authCubit.ageCounter.toString());
                            CacheHelper().saveData(
                                key: 'weigth',
                                value: authCubit.weightCounter.toString());
                            CacheHelper().saveData(
                                key: 'height',
                                value: authCubit.heightCounter.toString());
                            CacheHelper().removeData(key: 'email');
                            CacheHelper().removeData(key: 'name');
                            CacheHelper().removeData(key: 'password');
                            CacheHelper()
                                .removeData(key: 'passwordConfirmation');
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
