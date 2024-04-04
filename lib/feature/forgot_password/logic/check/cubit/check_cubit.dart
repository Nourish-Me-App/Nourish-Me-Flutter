import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/feature/forgot_password/data/repositories/check_code.dart';

part 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {
  CheckCubit(this.checkCodeRepository) : super(CheckInitial());

  CheckCodeRepository checkCodeRepository;

  Future verifyCode({
    required String email,
    required String token,
  }) async {
    try {
      emit(CheckLoading());
      await checkCodeRepository.chcekCode(email: email, token: token);
      emit(CheckSuccess());
    } on Exception catch (e) {
      log(e.toString());
      emit(CheckFailure());
    }
  }
}
