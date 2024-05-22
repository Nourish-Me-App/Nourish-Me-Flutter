part of 'counter_cubit_cubit.dart';

@immutable
abstract class CounterCubitState {
  final int age;
  final int height;
  final int weight;

  const CounterCubitState(this.age, this.height, this.weight);
}

class CounterInitial extends CounterCubitState {
  const CounterInitial() : super(0, 18, 160);
}

class CounterIncreased extends CounterCubitState {
  const CounterIncreased( super.age, super.height, super.weight);
}

class CounterDecreased extends CounterCubitState {
  const CounterDecreased( super.age, super.height, super.weight);
}
