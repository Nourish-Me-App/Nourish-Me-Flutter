part of 'check_cubit.dart';

@immutable
sealed class CheckState {}

final class CheckInitial extends CheckState {}

final class CheckLoading extends CheckState {}

final class CheckSuccess extends CheckState {}

final class CheckFailure extends CheckState {}
