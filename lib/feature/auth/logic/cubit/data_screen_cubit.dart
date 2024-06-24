import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/continue_register_repo.dart';

part 'data_screen_state.dart';

class DataScreenCubit extends Cubit<DataScreenState> {
  DataScreenCubit(
    this.continueRegisterRepo,
  ) : super(DataScreenInitial());
  late ContinueRegisterRepo continueRegisterRepo;
  int ageCounter = 18;
  int weightCounter = 50;
  int heightCounter = 160;
  //Timer? _timerAge;
  Timer? _timerHeight;
  Timer? _timerWeight;

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



  void stopTimerWeight() {
    _timerWeight?.cancel();
  }

  void stopTimerHeight() {
    _timerHeight?.cancel();
  }
}
