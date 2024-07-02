part of 'workout_cubit.dart';

@immutable
sealed class WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

final class WorkoutLoadingState extends WorkoutState {}

final class WorkoutSuccessState extends WorkoutState {
  final WorkOutModel workoutModel;
  WorkoutSuccessState(this.workoutModel);
}

final class WorkoutFailureState extends WorkoutState {
  final String error;
  WorkoutFailureState(this.error);
}