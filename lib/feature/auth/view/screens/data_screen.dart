import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/auth_requests.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/continue_register_model.dart';
import '../../logic/cubit/data_screen_cubit.dart';
import '../widgets/continue_register_lable.dart';
import '../widgets/counter_age.dart';
import '../widgets/custom_radio.dart';
import '../widgets/height_counter.dart';
import '../widgets/weightcounters.dart';

class ContinueRegisterScreen extends StatefulWidget {
  final String? loginType;
  const ContinueRegisterScreen({super.key, required this.loginType});

  @override
  State<ContinueRegisterScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<ContinueRegisterScreen> {
  String? type;
  String? selectedValue;
  late DataScreenCubit dataScreenCubit;
  @override
  void initState() {
    dataScreenCubit = BlocProvider.of<DataScreenCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ContinueRegisterModel continueRegisterModel = ContinueRegisterModel();
    return BlocConsumer<DataScreenCubit, DataScreenState>(
      listener: (context, state) {
        if (widget.loginType != 'googleLogin') {
          if (state is ContinueRegisterSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            HelperMethods.showCustomSnackBarError(
              context,
              ErrorMessages.errorMessage(state.error!),
            );
          }
          if (state is ContinueRegisterLoading) {
            HelperMethods.showLoadingAlertDialog(context);
          }
        }
        if (widget.loginType == 'googleLogin') {
          if (state is ContinueGoogleRegisterSuccess) {
            Navigator.pop(context);
            log(state.continueRegisterModel.data!.massIndex.toString());
            CacheHelper().saveData(
                key: 'googleBmi',
                value: state.continueRegisterModel.data!.massIndex);
                log('${CacheHelper().getData(key: 'googleBmi')}');
            CacheHelper().saveData(key: 'isDataSaved', value: 'yes');
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            HelperMethods.showCustomSnackBarSuccess(
                context, 'تم تسجيل البيانات بنجاح');
            CacheHelper().getData(key: 'isFirstQuestionsCompleteGoogle') ==
                    'yes'
                ? Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.bottomNavBar,
                    (route) => false,
                  )
                : Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.questions,
                    arguments: 'googleLogin',
                    (route) => false,
                  );
          }
          if (state is ContinueGoogleRegisterFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            HelperMethods.showCustomSnackBarError(
              context,
              ErrorMessages.errorMessage(state.error!),
            );
          }
          if (state is ContinueGoogleRegisterLoading) {
            HelperMethods.showLoadingAlertDialog(context);
          }
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
                child: Form(
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
                            imge: Assets.svgsAuthMale,
                            gender: 'ذكر',
                            value: 'ذكر',
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                              log(value.toString());
                            },
                          ),
                          CustomRadio(
                            imge: Assets.svgsAuthFemale,
                            gender: 'أنثى',
                            value: 'أنثى',
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                              log(value!.toString());
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
                        buttonText: 'متابعة',
                        buttonStyle: AppTextStyles.cairo16BoldWhite,
                        buttonAction: () async {
                          final age = dataScreenCubit.ageCounter;
                          final weight = dataScreenCubit.weightCounter;
                          final height = dataScreenCubit.heightCounter;
                          if (selectedValue == null) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            HelperMethods.showCustomSnackBarError(
                                context, 'من فضلك قم بتحدي الجنس');
                          } else if (age < 18 || age > 80) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            HelperMethods.showCustomSnackBarError(
                                context, 'العمر يجب أن يكون بين 18 و 80');
                          } else if (weight < 40 || weight > 160) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            HelperMethods.showCustomSnackBarError(
                                context, 'kg الوزن يجب أن يكون بين 40 و 160');
                          } else if (height < 140 || height > 210) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            HelperMethods.showCustomSnackBarError(
                                context, 'cm الطول يجب أن يكون بين 140 و 210');
                          } else {
                            CacheHelper cacheHelper = CacheHelper();
                            widget.loginType == 'googleLogin'
                                ? await dataScreenCubit.continueGoogleRegister(
                                    'users/google/continue/registration', {
                                    'gender': selectedValue.toString(),
                                    'weight': dataScreenCubit.weightCounter
                                        .toString(),
                                    'age':
                                        dataScreenCubit.ageCounter.toString(),
                                    'height': dataScreenCubit.heightCounter
                                        .toString(),
                                  })
                                : await AuthRequests.continueRegister(
                                    datascreeCubit: dataScreenCubit,
                                    continueRegisterModel:
                                        continueRegisterModel,
                                    email: cacheHelper.getData(key: 'email'),
                                    name: cacheHelper.getData(key: 'name'),
                                    gender: selectedValue.toString(),
                                    age: dataScreenCubit.ageCounter.toString(),
                                    weight: dataScreenCubit.weightCounter
                                        .toString(),
                                    height: dataScreenCubit.heightCounter
                                        .toString(),
                                    password:
                                        cacheHelper.getData(key: 'password'),
                                    passwordConfirmation: CacheHelper()
                                        .getData(key: 'passwordConfirmation'),
                                  ).then((value) {
                                    cacheHelper.removeData(key: 'email');
                                    cacheHelper.removeData(key: 'name');
                                    cacheHelper.removeData(key: 'password');
                                    cacheHelper.removeData(
                                        key: 'passwordConfirmation');
                                  });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
