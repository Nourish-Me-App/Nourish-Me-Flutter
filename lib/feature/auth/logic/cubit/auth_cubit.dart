import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/login_model.dart';
import '../../data/repositories/continue_register_repo.dart';
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
  int ageCounter = 18;
  int weightCounter = 50;
  int heightCounter = 160;
  Timer? _timerAge;
  Timer? _timerHeight;
  Timer? _timerWeight;
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

  void startTimerIncreaseAge() {
    _timerAge = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      ageCounter++;
      emit(IncreamentCounter());
    });
  }

  void startTimerIncreaseHeight() {
    _timerHeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      heightCounter++;
      emit(IncreamentCounter());
    });
  }

  void startTimerIncreaseWeight() {
    _timerWeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      weightCounter++;
      emit(IncreamentCounter());
    });
  }

  void startTimerDecreaseAge() {
    _timerAge = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      ageCounter--;
      emit(DecreamentCounter());
    });
  }

  void startTimerDecreaseHeight() {
    _timerHeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      heightCounter--;
      emit(IncreamentCounter());
    });
  }

  void startTimerDecreaseWeight() {
    _timerWeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      weightCounter--;
      emit(IncreamentCounter());
    });
  }

  void stopTimer() {
    _timerAge?.cancel();
    _timerWeight?.cancel();
    _timerHeight?.cancel();
  }
}
