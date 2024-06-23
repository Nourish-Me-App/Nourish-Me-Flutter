part of 'bot_nav_bar_cubit.dart';

@immutable
sealed class BotNavBarState {}

final class BotNavBarInitial extends BotNavBarState {}

final class IndexChanged extends BotNavBarState {}
