import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/login_model.dart';
import '../../data/repositories/login_repo.dart';
import '../../data/repositories/signup_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginRepo, this.signUpRepo)
      : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool rememberMe = false;
  late LoginRepo loginRepo;
  late SignUpRepo signUpRepo;

  Future<void> login(String path, dynamic data) async {
    emit(LoginLoading());
    final loginModel = await loginRepo.login(
      path,
      data,
    );
    loginModel.fold((error) {
      emit(LoginFailure(error: error));
    }, (loginModel) {
      emit(LoginSuccess(loginModel: loginModel));
    });
  }
  Future<void> googleLogin(String path, dynamic data) async {
    emit(GoogleLoginLoading());
    final loginModel = await loginRepo.googleLogin(
      path,
      data,
    );
    loginModel.fold((error) {
      emit(GoogleLoginFailure(error: error));
    }, (loginModel) {
      emit(GoogleLoginSuccess(loginModel: loginModel));
    });
  }

  Future<void> signUp(String path, dynamic data) async {
    emit(SignUpLoading());
    final signUpModel = await signUpRepo.signUp(
      path,
      data,
    );
    signUpModel.fold(
      ((error) {
        emit(SignUpFailure(error: error));
      }),
      ((signUpModel) {
        emit(SignUpSuccess());
      }),
    );
  }
}
