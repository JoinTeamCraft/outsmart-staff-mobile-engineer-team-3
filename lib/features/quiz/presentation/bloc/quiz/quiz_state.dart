part of 'quiz_cubit.dart';

/// Represents the possible states of the [QuizCubit].
@freezed
class QuizState with _$QuizState {
  /// The initial state when the quiz is first initialized.
  const factory QuizState.initial() = _Initial;

  /// The state while the quiz data is being fetched.
  const factory QuizState.loading() = _Loading;

  /// The state when the quiz is successfully loaded.
  const factory QuizState.loaded(Quiz quiz) = _Loaded;

  /// The state when an error occurs during the quiz session.
  ///
  /// The [message] provides details about the failure.
  const factory QuizState.error({required String message}) = _Error;
}
