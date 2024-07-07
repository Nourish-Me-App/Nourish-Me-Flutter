import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../data/models/logout_model.dart';
import '../../data/models/update_profile_model.dart';
import '../../data/repositories/logout_repo.dart';
import '../../data/repositories/update_profile_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController =
      TextEditingController();
  XFile? image;
  ImagePicker imagePicker = ImagePicker();
  late LogoutRepo logoutRepo;
  late UpdateProfileRepo updateProfileRepo;
  SettingsCubit(this.logoutRepo, this.updateProfileRepo)
      : super(SettingsInitial());

  Future<void> logout(
    String path,
  ) async {
    emit(LogoutLoading());
    var response = await logoutRepo.logout(
        path,
        (await CacheHelper().getSecuredData(key: 'googleToken')) == null
            ? (await CacheHelper().getSecuredData(key: AppConstants.token))!
            : (await CacheHelper().getSecuredData(key: 'googleToken'))!);

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
      (await CacheHelper().getSecuredData(key: 'googleToken')) == null
          ? (await CacheHelper().getSecuredData(key: AppConstants.token))!
          : (await CacheHelper().getSecuredData(key: 'googleToken'))!,
      data,
    );

    response.fold((error) {
      emit(UpdateProfileFailed(error: error));
    }, (updateProfileModel) {
      emit(UpdateProfileSuccess(updateProfileModel: updateProfileModel));
    });
  }

  Future<XFile?> galleryPick() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = pickedImage;
      emit(ImagePicked());
      return image!;
    } else {
      return null;
    }
  }

  Future<XFile?> cameraPick() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = pickedImage;
      emit(ImagePicked());
      return image!;
    } else {
      return null;
    }
  }
}
