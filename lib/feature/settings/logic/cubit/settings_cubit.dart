import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/feature/settings/data/repositories/update_profile_repo.dart';
import '../../data/models/logout_model.dart';
import '../../data/models/update_profile_model.dart';
import '../../data/repositories/logout_repo.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController =
      TextEditingController();
  late LogoutRepo logoutRepo;
  late UpdateProfileRepo updateProfileRepo;
  SettingsCubit(this.logoutRepo, this.updateProfileRepo)
      : super(SettingsInitial());

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

  Future<void> updateProfile(
    String path,
    dynamic data,
  ) async {
    emit(UpdateProfileLoading());
    var response = await updateProfileRepo.updateProfile(
      path,
      CacheHelper().getData(key: AppConstants.token),
      data,
    );

    response.fold((error) {
      emit(UpdateProfileFailed(error: error));
    }, (updateProfileModel) {
      emit(UpdateProfileSuccess(updateProfileModel: updateProfileModel));
    });
  }
}
