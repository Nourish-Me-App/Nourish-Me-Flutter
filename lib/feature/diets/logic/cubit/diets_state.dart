part of 'diets_cubit.dart';

@immutable
sealed class DietsState {}

final class DietsInitial extends DietsState {}

final class DietsSuccessState extends DietsState {
  final DietsModel dietsModel;
  DietsSuccessState(this.dietsModel);
}

final class DietsFailureState extends DietsState {
  final String error;
  DietsFailureState(this.error);
}

final class DietsLoadingState extends DietsState {}
