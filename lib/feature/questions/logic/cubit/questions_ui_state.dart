part of 'questions_ui_cubit.dart';

@immutable
sealed class QuestionsUIState {}

final class QuestionsUIInitial extends QuestionsUIState {}

final class CheckQuestionNumberState extends QuestionsUIState {}

final class RadioValueChosed extends QuestionsUIState {}

final class Validated extends QuestionsUIState {}
