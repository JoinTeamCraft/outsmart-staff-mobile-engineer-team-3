import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:streaklearn/core/errors/data_result.dart';
import 'package:streaklearn/features/quiz/models/quiz.dart';
import 'package:streaklearn/features/quiz/repositories/quiz_repository.dart';

part 'quiz_state.dart';
part 'quiz_cubit.freezed.dart';

/// {@template quiz_cubit}
/// The manager for the quiz state and lifecycle.
/// {@endtemplate}
class QuizCubit extends Cubit<QuizState> {
  /// {@macro quiz_cubit}
  ///
  /// Creates an instance of [QuizCubit].
  QuizCubit(this._quizRepository) : super(const QuizState.initial());

  final QuizRepository _quizRepository;

  /// Fetches the quiz associated with [lessonId].
  Future<void> fetchByLessonId(String lessonId) async {
    emit(const QuizState.loading());

    final result = await _quizRepository.getQuizByLessonId(lessonId);
    switch (result) {
      case DataSuccess<Quiz>(:final data):
        emit(QuizState.loaded(data));
      case DataFailure<Quiz>(:final failure):
        emit(QuizState.error(message: failure.message));
    }
  }
}
