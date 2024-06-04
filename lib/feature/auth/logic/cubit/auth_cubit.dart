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
    if (ageCounter < 80) {
      ageCounter++;
      emit(IncreamentCounter());
    }
  }

  void decrementAge() {
    emit(LoadingCounter());
    if (ageCounter > 12) {
      ageCounter--;
      emit(DecreamentCounter());
    }
  }

  void updateAge(int age) {
    emit(LoadingCounter());
    ageCounter = age;
    emit(IncreamentCounter());
  }

  void onpreesedincreamnetWeight() {
    emit(LoadingCounter());
    weightCounter = weightCounter + 1;
    emit(IncreamentCounter());
  }

  void decrementWeight() {
    emit(LoadingCounter());
    if (weightCounter > 50) {
      weightCounter--;
      emit(DecreamentCounter());
    }
    emit(DecreamentCounter());
  }

  void onPreesedIncreamnetHeight() {
    emit(LoadingCounter());
    heightCounter = heightCounter + 1;
    emit(IncreamentCounter());
  }

  void updateWeight(int weight) {
    emit(LoadingCounter());
    weightCounter = weight;
    emit(IncreamentCounter());
  }

  void incrementWeight() {
    emit(LoadingCounter());
    weightCounter++;
    emit(IncreamentCounter());
  }

  void decrementHeight() {
    emit(LoadingCounter());
    if (heightCounter > 140) {
      heightCounter--;
      emit(DecreamentCounter());
    }
    emit(DecreamentCounter());
  }

  void incrementHeight() {
    emit(LoadingCounter());
    if (heightCounter < 210) {
      heightCounter++;
      emit(IncreamentCounter());
    }
  }

  void updateHeight(int height) {
    emit(LoadingCounter());
    heightCounter = height;
    emit(IncreamentCounter());
  }

  void startTimerIncreaseAge() {
    _timerAge = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (ageCounter < 80) {
        ageCounter++;
        emit(IncreamentCounter());
      }
    });
  }

  void startTimerIncreaseHeight() {
    _timerHeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (heightCounter < 210) {
        heightCounter++;
        emit(IncreamentCounter());
      }
    });
  }

  void startTimerIncreaseWeight() {
    _timerWeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (weightCounter < 160) {
        weightCounter++;
        emit(IncreamentCounter());
      }
    });
  }

  void startTimerDecreaseAge() {
    _timerAge = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (ageCounter >= 12) {
        ageCounter--;
        emit(DecreamentCounter());
      }
    });
  }

  void startTimerDecreaseHeight() {
    _timerHeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (heightCounter > 160) {
        heightCounter--;
        emit(DecreamentCounter());
      }
    });
  }

  void startTimerDecreaseWeight() {
    _timerWeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (weightCounter > 50) {
        weightCounter--;
        emit(DecreamentCounter());
      }
    });
  }

  void stopTimerAge() {
    _timerAge?.cancel();
  }

  void stopTimerWeight() {
    _timerWeight?.cancel();
  }

  void stopTimerHeight() {
    _timerHeight?.cancel();
  }
}
