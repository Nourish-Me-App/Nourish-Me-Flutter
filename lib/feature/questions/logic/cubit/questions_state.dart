part of 'questions_cubit.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class CheckQuestionNumberState extends QuestionsState {}

final class RadioValueChosed extends QuestionsState {}
final class Validated extends QuestionsState {}
