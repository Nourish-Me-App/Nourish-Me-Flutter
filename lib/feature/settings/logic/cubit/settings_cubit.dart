import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/logout_model.dart';
import '../../data/repositories/logout_repo.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late LogoutRepo logoutRepo;
  SettingsCubit(this.logoutRepo) : super(SettingsInitial());

  Future<void> logout(
    String path,
  ) async {
    emit(LogoutLoading());
    var response = await logoutRepo.logout(
        path, CacheHelper().getData(key: AppConstants.token));

    response.fold((error) {
      emit(LogoutFailed(error: error));
    }, (logoutModel) {
      emit(LogoutSuccess(logoutModel: logoutModel));
    });
  }
}
