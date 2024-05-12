import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/helpers/image_assets.dart';
import '../../../core/imports/app_routes_imports.dart';

import '../data/model/on_boarding_model.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  List<OnBoardingModel> onBoardingList = <OnBoardingModel>[
    OnBoardingModel(
        description:
            'اهلا بك في تطبيقنا نحن نهدف الي حساب سعراتك الحرارية وتوفير خطة غذائية متوازنه و فعاله \n مخصصة لك  ',
        image: 'onBoarding1'.getSvgAsset),
    OnBoardingModel(
        description:
            'دليل مخصص لتحديد التمارين التي تناسب احتياجاتك ومستوى لياقتك البدنية لتوفير تجربة مميزة لتحسين صحتك الشخصية ونمط حياتك اليومية ',
        image: 'onBoarding2'.getSvgAsset),
    OnBoardingModel(
        description:
            'يستهدف تطبيقنا جميع الفئات  لذلك قمنا بتوفير خطط نظام غذائي مخصصه لمرضى السكر وضغط  الدم ',
        image: 'onBoarding3'.getSvgAsset),
  ];

  PageController pageController = PageController(initialPage: 0);

  int currentIndex = 0;
  changePage(int index) {
    currentIndex = index;
    emit(NextState());
  }

  transition() {
    if (currentIndex >= onBoardingList.length - 1) {
      emit(GoHomeState());
    } else {
      currentIndex++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
      emit(NextState());
    }
  }
}
