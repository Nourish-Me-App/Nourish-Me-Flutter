import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'questions_ui_state.dart';

class QuestionsUICubit extends Cubit<QuestionsUIState> {
  QuestionsUICubit() : super(QuestionsUIInitial());
  int? questionOneValue,
      questionTwoValue,
      questionFourValue,
      questionThreeValue,
      questionFiveValue,
      continueQuestionOneValue;
  List continueQuestionThreeValue = [
    false,
    false,
    false,
  ];
  List continueQuestionThreeValue2 = [
    false,
    false,
  ];
  double questionNumber = 0;
  bool questionOneValidate = false,
      questionTwoValidate = false,
      questionThreeValidate = false,
      questionFourValidate = false,
      questionFiveValidate = false,
      continueQuestionOneValidate = false;
  void checkQuestionNumber(String action) {
    if (action == 'السابق') {
      questionNumber--;
      emit(CheckQuestionNumberState());
    } else {
      questionNumber++;
      emit(CheckQuestionNumberState());
    }
  }

  void resetContinueQuestionThreeValueList() {
    continueQuestionThreeValue = [
      false,
      false,
      false,
    ];
  }

  void resetContinueQuestionThreeValueList2() {
    continueQuestionThreeValue2 = [
      false,
      false,
    ];
  }

  void onChangedRadioValue({
    dynamic value,
    int? questionNum,
    int? index,
  }) {
    switch (questionNum) {
      case 0:
        questionOneValue = value!;
        if (value == 1) continueQuestionOneValue = null;
        emit(RadioValueChosed());
      case 1:
        questionTwoValue = value!;
        emit(RadioValueChosed());
      case 2:
        questionThreeValue = value;
        emit(RadioValueChosed());
      case 3:
        questionFourValue = value!;
        emit(RadioValueChosed());
      case 4:
        questionFiveValue = value!;
        emit(RadioValueChosed());
      case 5:
        continueQuestionOneValue = value!;
        emit(RadioValueChosed());
      case 6:
        questionThreeValue == 0
            ? continueQuestionThreeValue[index!] = value!
            : continueQuestionThreeValue2[index!] = value!;
        emit(RadioValueChosed());
    }
  }

  cardNumber(int value) {
    if (value == 0) {
      return questionOneValue;
    } else if (value == 1) {
      return questionTwoValue;
    } else if (value == 2) {
      return questionThreeValue;
    } else if (value == 3) {
      return questionFourValue;
    } else if (value == 4) {
      return questionFiveValue;
    } else if (value == 5) {
      return continueQuestionOneValue;
    } else {
      return questionThreeValue == 0
          ? continueQuestionThreeValue
          : continueQuestionThreeValue2;
    }
  }

  checkRadioValue() {
    switch (questionNumber) {
      case 0:
        if (questionOneValue == null) {
          questionOneValidate = true;
          emit(Validated());
          return true;
        } else {
          if (questionOneValue == 0 && continueQuestionOneValue == null) {
            continueQuestionOneValidate = true;
            emit(Validated());
            return true;
          }
          return false;
        }
      case 1:
        if (questionTwoValue == null) {
          questionTwoValidate = true;
          emit(Validated());
          return true;
        } else {
          return false;
        }
      case 2:
        if (questionThreeValue == null) {
          questionThreeValidate = true;
          emit(Validated());
          return true;
        } else {
          return false;
        }
      case 3:
        if (questionFourValue == null) {
          questionFourValidate = true;
          emit(Validated());
          return true;
        } else {
          return false;
        }
      case 4:
        if (questionFiveValue == null) {
          questionFiveValidate = true;
          emit(Validated());
          return true;
        } else {
          return false;
        }
    }
  }

  clearValidation() {
    switch (questionNumber) {
      case 0:
        questionOneValidate = false;
        continueQuestionOneValidate = false;
        emit(Validated());
      case 1:
        questionTwoValidate = false;
        emit(Validated());
      case 2:
        questionThreeValidate = false;
        emit(Validated());
      case 3:
        questionFourValidate = false;
        emit(Validated());
      case 4:
        questionFiveValidate = false;
        emit(Validated());
    }
  }

  validate() {
    switch (questionNumber) {
      case 0:
        if (questionOneValidate == true) {
          return true;
        } else {
          if (continueQuestionOneValidate == true) {
            return true;
          }
          return false;
        }
      case 1:
        if (questionTwoValidate == true) {
          return true;
        } else {
          return false;
        }
      case 2:
        if (questionThreeValidate == true) {
          return true;
        } else {
          return false;
        }
      case 3:
        if (questionFourValidate == true) {
          return true;
        } else {
          return false;
        }
      case 4:
        if (questionFiveValidate == true) {
          return true;
        } else {
          return false;
        }
    }
  }
}
