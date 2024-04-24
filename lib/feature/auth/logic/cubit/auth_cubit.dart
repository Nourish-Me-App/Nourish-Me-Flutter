import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/core/imports/signup_screen_imports.dart';
import 'package:nourish_me/feature/auth/data/repositories/continue_register_repo.dart';
import '../../data/models/login_model.dart';
import '../../data/repositories/login_repo.dart';
import '../../data/repositories/signup_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginRepo, this.signUpRepo, this.continueRegisterRepo)
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
  late ContinueRegisterRepo continueRegisterRepo;

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

  Future<void> continueRegister(String path, dynamic data) async {
    emit(ContinueRegisterLoading());
    final continueRegisterModel = await continueRegisterRepo.continueRegister(
      path,
      data,
    );
    continueRegisterModel.fold(
      ((error) {
        emit(ContinueRegisterFailure(error: error));
      }),
      ((continueRegisterModel) {
        emit(ContinueRegisterSuccess());
      }),
    );
  }

  int ageCounter = 0;
  void increamnetAge() {
    emit(LoadingCounter());
    ageCounter++;
    emit(IncreamentCounter());
  }

  void decrementAge() {
    emit(LoadingCounter());
    ageCounter--;
    emit(DecreamentCounter());
  }

  int weightCounter = 50;
  void onlongPressedincreamnetWeight() {
    emit(LoadingCounter());
    weightCounter = weightCounter + 5;
    emit(IncreamentCounter());
  }

  void onpreesedincreamnetWeight() {
    emit(LoadingCounter());
    weightCounter = weightCounter + 1;
    emit(IncreamentCounter());
  }

  void decrementWeight() {
    emit(LoadingCounter());
    weightCounter--;
    emit(DecreamentCounter());
  }

  int heightCounter = 160;
  void onLongPressedincreamnetHeight() {
    emit(LoadingCounter());
    heightCounter = heightCounter + 5;
    emit(IncreamentCounter());
  }

  void onPreesedIncreamnetHeight() {
    emit(LoadingCounter());
    heightCounter = heightCounter + 1;
    emit(IncreamentCounter());
  }

  void decrementHeight() {
    emit(LoadingCounter());
    heightCounter--;
    emit(DecreamentCounter());
  }
}
