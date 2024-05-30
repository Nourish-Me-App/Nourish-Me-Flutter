import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/core/helpers/app_constants.dart';
import 'package:nourish_me/core/helpers/cache_helper.dart';
import 'package:nourish_me/feature/home/data/model/home_model.dart';
import 'package:nourish_me/feature/home/data/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;

  bool isReceived = false;

  HomeModel? cachedData;

  Future<void> fetchHomeData(String path) async {
    if (!isReceived || cachedData == null) {
      emit(HomeLoadingState());
      try {
        var result = await homeRepo.getHomeData(
          path,
          CacheHelper().getData(key: AppConstants.token),
        );
        result.fold(
          (error) => emit(HomeFailureState(error: error)),
          (homeModel) {
            cachedData = homeModel;
            isReceived = true;
            emit(HomeSuccessState(homeModel: homeModel));
          },
        );
      } catch (e) {
        emit(HomeFailureState(error: e.toString()));
      }
    } else {
      emit(HomeSuccessState(homeModel: cachedData!));
    }
  }
}
