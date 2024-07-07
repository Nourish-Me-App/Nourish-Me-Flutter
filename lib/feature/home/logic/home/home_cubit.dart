import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../data/model/home_model.dart';
import '../../data/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  late HomeRepo homeRepo;

  Future<void> fetchHomeData(String path) async {
    emit(HomeLoadingState());
    try {
      var result = await homeRepo.getHomeData(
          path,
          (await CacheHelper().getSecuredData(key: 'googleToken')) == null
              ? (await CacheHelper().getSecuredData(key: AppConstants.token))!
              : (await CacheHelper().getSecuredData(key: 'googleToken'))!);
      result.fold(
        (error) => emit(HomeFailureState(error: error)),
        (homeModel) => emit(HomeSuccessState(homeModel: homeModel)),
      );
    } catch (e) {
      emit(HomeFailureState(error: e.toString()));
    }
  }
}
