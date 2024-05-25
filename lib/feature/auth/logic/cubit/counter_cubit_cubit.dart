import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_cubit_state.dart';

class CounterCubit extends Cubit<CounterCubitState> {
  CounterCubit() : super(const CounterInitial());
  Timer? _increaseTimer;
  Timer? _decreaseTimer;

  void startIncreaseTimer() {
    _stopDecreaseTimer();
    _increaseTimer?.cancel(); // Cancel any existing timer
    _increaseTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      emit(CounterIncreased( state.age, state.height, state.weight)); // Increment state by 1
    });
  }

  void startDecreaseTimer() {
    _stopIncreaseTimer();
    _decreaseTimer?.cancel(); // Cancel any existing timer
    _decreaseTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      emit(CounterDecreased( state.age, state.height, state.weight)); // Decrement state by 1
    });
  }

  void stopTimers() {
    _stopIncreaseTimer();
    _stopDecreaseTimer();
  }

  void _stopIncreaseTimer() {
    _increaseTimer?.cancel();
  }

  void _stopDecreaseTimer() {
    _decreaseTimer?.cancel();
  }

  void incrementAge() {
    emit(CounterIncreased( state.age + 1, state.height, state.weight));
  }

  void decrementAge() {
    emit(CounterDecreased( state.age - 1, state.height, state.weight));
  }

  void incrementHeight() {
    emit(CounterIncreased( state.age, state.height + 1, state.weight));
  }

  void decrementHeight() {
    emit(CounterDecreased( state.age, state.height - 1, state.weight));
  }

  void incrementWeight() {
    emit(CounterIncreased(state.age, state.height, state.weight + 1));
  }

  void decrementWeight() {
    emit(CounterDecreased( state.age, state.height, state.weight - 1));
  }

  @override
  Future<void> close() {
    _stopIncreaseTimer();
    _stopDecreaseTimer();
    return super.close();
  }
}
