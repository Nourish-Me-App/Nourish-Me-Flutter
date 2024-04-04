part of 'reset_cubit.dart';

@immutable
sealed class ResetState {}

final class ResetInitial extends ResetState {}

final class ResetLoading extends ResetState {}

final class ResetSuccess extends ResetState {}

final class ResetFailure extends ResetState {}
