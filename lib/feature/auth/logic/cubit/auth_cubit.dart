import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/feature/auth/data/models/login_model.dart';

import '../../data/models/signup_model.dart';
import '../../data/repositories/login_repo.dart';
import '../../data/repositories/signup_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginRepo,this.signUpRepo) : super(AuthInitial());

  late LoginRepo loginRepo;
  late SignUpRepo signUpRepo;

  Future<LoginModel> login(String path, dynamic data) async {
    emit(LoginLoading());
    try {
      final loginModel = await loginRepo.login(
        path,
        data,
      );
      log('statusCode: ${loginModel.statusCode}');
      emit(LoginSuccess());
      return loginModel;
    } catch (e) {
      log('cubit: ${e.toString()}');
      emit(LoginFailure());
    }
    return LoginModel();
  }

  Future<SignUpModel> signUp(
   String path,dynamic data
  ) async {
    emit(SignUpLoading());
    try {
      final signUpModel = await signUpRepo.signUp(
        path,
        data,
      );
      emit(SignUpSuccess());
      return signUpModel;
    } catch (e) {
      log(e.toString());
      emit(SignUpFailure());
    }
    return SignUpModel();
  }
}
