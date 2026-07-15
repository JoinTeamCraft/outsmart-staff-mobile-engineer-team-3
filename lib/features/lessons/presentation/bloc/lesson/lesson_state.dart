part of 'lesson_cubit.dart';

/// Represents the possible states of the [LessonCubit].
@freezed
class LessonState with _$LessonState {
  /// The initial state when the cubit is first created.
  const factory LessonState.initial() = _Initial;

  /// The state while the lesson data is being fetched.
  const factory LessonState.loading() = _Loading;

  /// The state when the lesson data is successfully loaded.
  // TODO: add the list of lessons entity.
  const factory LessonState.loaded() = _Loaded;

  /// The state when an error occurs.
  ///
  /// The [message] describes the cause of the error.
  const factory LessonState.error(String message) = _Error;
}
