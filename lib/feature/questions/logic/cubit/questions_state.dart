part of 'questions_cubit.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class QuestionsSuccessState extends QuestionsState {
  final QuestionAndAnswerModel questionAndAnswerModel;
  QuestionsSuccessState(this.questionAndAnswerModel);
}

final class QuestionsFailureState extends QuestionsState {
  final String error;
  QuestionsFailureState(this.error);
}

final class QuestionsLoadingState extends QuestionsState {}

final class PostQuestionsSuccessState extends QuestionsState {
  final String message;
  PostQuestionsSuccessState(this.message);
}

final class PostQuestionsFailureState extends QuestionsState {
  final String error;
  PostQuestionsFailureState(this.error);
}

final class PostQuestionsLoadingState extends QuestionsState {}
