import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../data/models/diets_model.dart';
import '../../data/repositories/diets_repo.dart';

part 'diets_state.dart';

class DietsCubit extends Cubit<DietsState> {
  late DietsRepo dietsRepo;
  DietsCubit(this.dietsRepo) : super(DietsInitial());

  Future<void> fetchDietMeals(String path) async {
    emit(DietsLoadingState());
    var result = await dietsRepo.getDietMeals(
        path,(await CacheHelper().getSecuredData(key: 'googleToken')) == null
            ? (await CacheHelper().getSecuredData(key: AppConstants.token))!
            : (await CacheHelper().getSecuredData(key: 'googleToken'))!);
    result.fold(
      (error) => emit(DietsFailureState(error)),
      (dietModel) {
        emit(DietsSuccessState(dietModel));
      },
    );
  }
}
