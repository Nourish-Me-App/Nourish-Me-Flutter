import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/feature/forgot_password/data/repositories/reser_password_repo.dart';

part 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  ResetCubit(this.resetPasswordRepositories) : super(ResetInitial());

  ResetPasswordRepositories resetPasswordRepositories;
  Future resetPassword(
      {required String email,
      required String newpassword,
      required String confirmpassword}) async {
    try {
      emit(ResetLoading());
      await resetPasswordRepositories.resetPassword(
          email: email,
          newpassword: newpassword,
          confirmpassword: confirmpassword);
      emit(ResetSuccess());
    } on DioException catch (e) {
      log(e.toString());
      emit(ResetFailure());
    }
    return ResetPasswordRepositories();
  }
}
